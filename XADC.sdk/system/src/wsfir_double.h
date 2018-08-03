/*
 * wsfir.h
 *
 *  Created on: Jan 12, 2017
 *      Author: rd
 */

#ifndef WSFIR_H_
#define WSFIR_H_
// Lib
//#include <stdio.h>
#include <math.h>
//Fce
double * wsfirLP(const int N, const int WINDOW, const double fc);
double * genSinc(const int N, const double fc);
double * wBlackman(const int N);
double * wHanning(const int N);
double * wHamming(const int N);
double * wBlackmanHarris(const int N);

// functions
double * wsfirLP(const int N,		// size of the filter (number of taps)
			 const int WINDOW,	// window function (W_BLACKMAN, W_HANNING, etc.)
			 const double fc)	// cutoff frequency
{
	int i;
	double wslp[N];
	// 1. Generate Sinc function
	double *sincd = genSinc(N, fc);
	double *winfc;
	// 2. Generate Window function
	switch (WINDOW) {
		case 1:	// W_BLACKMAN
			winfc = wBlackman(N);
			break;
		case 2:		// W_HANNING
			winfc = wHanning(N);
			break;
		case 3:		// W_HAMMING
			winfc = wHamming(N);
			break;
		case 4:		// W_BLACMAN_HARRIS
			winfc = wBlackmanHarris(N);
			break;
		default:
			break;
	}
	// 3. Make lowpass filter
	for (i = 0; i < N; i++) {
		wslp[i] = sincd[i] * winfc[i];

	}
	return wslp;
}

// Generate sinc function - used for making lowpass filter
double * genSinc(const int N,		// size (number of taps)
			 const double fc)	// cutoff frequency
{
	int i;
	const double M = N-1;
	double n;
	double h[N];
	// Constants
	const double PI = 3.14159265358979323846;

	// Generate sinc delayed by (N-1)/2
	for (i = 0; i < N; i++) {
		if (i == M/2.0) {
			h[i] = 2.0 * fc;
		}
		else {
			n = (double)i - M/2.0;
			h[i] = sin(2.0*PI*fc*n) / (PI*n);
		}
	}
	return h;
}
// Generate window function (Blackman)
double * wBlackman(const int N)	// size of the window
{
	int i;
	const double M = N-1;
	const double PI = 3.14159265358979323846;
	double h[N];
	for (i = 0; i < N; i++) {
		h[i] = 0.42 - (0.5 * cos(2.0*PI*(double)i/M)) + (0.08*cos(4.0*PI*(double)i/M));
	}
	return h;
}
// Generate window function (Hamming)
double * wHamming(const int N)		// size of the window
{
	int i;
	const double M = N-1;
	const double PI = 3.14159265358979323846;
	double h[N];
	for (i = 0; i < N; i++) {
		h[i] = 0.54 - (0.46*cos(2.0*PI*(double)i/M));
	}
	return h;
}
// Generate window function (Hanning)
double * wHanning(const int N)		// size of the window
{
	int i;
	const double M = N-1;
	const double PI = 3.14159265358979323846;
	double h[N];
	for (i = 0; i < N; i++) {
		h[i] = 0.5 * (1.0 - cos(2.0*PI*(double)i/M));
	}
	return h;
}
// Blackman–Harris window
double * wBlackmanHarris(const int N)
{
	int i;
    const double M = N-1;
	const double PI = 3.14159265358979323846;
	double h[N];
    for(i=0;i<N;i++) {
        h[i] = 0.35875-(0.48829*cosf((2.0*PI*i)/M ))+(0.14128*cosf((4.0*PI*i)/M))-(0.01168*cosf((6.0*PI*i)/M));
    }
    return h;
}
#endif /* WSFIR_H_ */
