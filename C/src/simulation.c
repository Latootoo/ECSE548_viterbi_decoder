#include "../inc/simulation.h"


void simulate(char *file) {
	int i, Ferr, run, EbNo_count = 0;
	int num_frames;
	double BER, FER;
	char *str;
	FILE *fp, *fvsim = NULL;
	
	simparams_t simparams;
	code_t code;
	uint8_t *m;
	uint8_t *c;
	int8_t *x;
	double *y;
	uint8_t *m_est;
	
	simparams_load(&simparams, file);
	code_load(&code, simparams.N, simparams.K, simparams.G);
	modulator_modulate_codebook(&code, simparams.MODULATOR);
	m = (uint8_t *)malloc(simparams.K*sizeof(*m));
	c = (uint8_t *)malloc(simparams.N*sizeof(*c));
	x = (int8_t *)malloc(simparams.N*sizeof(*x));
	y = (double *)malloc(simparams.N*sizeof(*y));
	m_est = (uint8_t *)malloc(simparams.K*sizeof(*m_est));
	
	//Give each simulation the same inputs and noise
	srand(21);
	
	str = (char *)malloc((strlen(file) + 13)*sizeof(char));
	str[0] = '\0';
	
	strcat(str, RESULTS_DIR);
	strcat(str, "/");
	strcat(str, file);
	fp = fopen(str, "w+");
	
	if(simparams.PRINT_VALS)
		fvsim = fopen("../modelsim/inputs.txt", "w+");
	
	fprintf(fp, "#Component\n");
	fprintf(fp, "#EbNo_db    BER         SER         FER         Av. Iters   Frame Count\n");
	while(EbNo_count < simparams.EbNo_STEPS) {
		num_frames = 0;
		BER = 0;
		FER = 0;
		run = 1;
		while(run) {
			datagen_generate(&m, code.K);
			encoder_encode(&c, m, code);
			modulator_modulate(&x, c, code, simparams.MODULATOR);
			channel_transmit(&y, x, simparams.EbNo_VALS[EbNo_count], code, simparams.CHANNEL);
			decoder_decode(&m_est, y, code, simparams.DECODER, simparams.MODULATOR, simparams.Q_N, simparams.Q_M);
			
			if(simparams.PRINT_VALS) {
				for(i=0 ; i<code.N ; i++)
					fprintf(fvsim, "%d ", fixedpoint_double2fixed(y[i], simparams.Q_N, simparams.Q_M));
				for(i=0 ; i<code.K ; i++)
					fprintf(fvsim, "%d ", m_est[i]);
				for(i=0 ; i<code.K ; i++)
					fprintf(fvsim, "%d ", m[i]);
				fprintf(fvsim, "\n");
			}
			
			Ferr = 0;
			for(i=0 ; i<code.K ; i++) {
				if(m[i] != m_est[i]) {
					Ferr = 1;	
					BER++;
				}
			}
			if(Ferr)
				FER++;
			num_frames++;
			
			if(!((num_frames<simparams.MIN_FRAMES) || (FER<simparams.MIN_ERRORS)))
				run = 0;
		}
		
		fprintf(fp, "%.5e %.5e %.5e %.5e %.5e %.5e\n", 
																									simparams.EbNo_VALS[EbNo_count],
																									BER/(num_frames*code.K),
																									BER/(num_frames*code.K),
																									FER/num_frames,
																									0.0,
																									(double)num_frames);
		EbNo_count++;
	}
	
	
	fclose(fp);
	if(simparams.PRINT_VALS)
		fclose(fvsim);
	
	free(m_est);
	free(y);
	free(x);
	free(c);
	free(m);
	code_free(&code);
	simparams_free(&simparams);

}


void simulation_run() {
	int i;
	
	system("exec rm -r ./results/*");
	simfiles_t simfiles;
	simparams_loadfiles(&simfiles);
	
	for(i=0 ; i<simfiles.num_files ; i++)
		simulate(simfiles.files[i]);
	
	simparams_freefiles(&simfiles);
}

