/*
 * wsfir.h
 *
 *  Created on: Jan 12, 2017
 *      Author: rd
 */
/*
	Windowed Sinc FIR Generator
	Bob Maling (BobM.DSP@gmail.com)
	Contributed to musicdsp.org Source Code Archive
	Last Updated: April 12, 2005

	Usage:
		Lowpass:	wsfirLP(h, N, WINDOW, fc)
		Highpass:	wsfirHP(h, N, WINDOW, fc)
		Bandpass:	wsfirBP(h, N, WINDOW, fc1, fc2)
		Bandstop:	wsfirBS(h, N, WINDOW, fc1, fc2)

	where:
		h (double[N]):	filter coefficients will be written to this array
		N (int):		number of taps
		WINDOW (int):	Window (W_BLACKMAN, W_HANNING, or W_HAMMING)
		fc (double):	cutoff (0 < fc < 0.5, fc = f/fs)
						--> for fs=48kHz and cutoff f=12kHz, fc = 12k/48k => 0.25

		fc1 (double):	low cutoff (0 < fc < 0.5, fc = f/fs)
		fc2 (double):	high cutoff (0 < fc < 0.5, fc = f/fs)


	Windows included here are Blackman, Hanning, and Hamming. Other windows	can be
	added by doing the following:
		1. "Window type constants" section: Define a global constant for the new window.
		2. wsfirLP() function: Add the new window as a case in the switch() statement.
		3. Create the function for the window

		   For windows with a design parameter, such as Kaiser, some modification
		   will be needed for each function in order to pass the parameter.
*/
#ifndef WSFIR_H_
#define WSFIR_H_

#include <stdio.h>
#include <math.h>
#include "global.h"

float iwAuthor[2048];
float SincFc[2048];

// Function prototypes
void wsfirLP(const int N, const int WINDOW, const float fc);
void wsfirHP(const int N, const int WINDOW, const float fc);
void wsfirBS(const int N, const int WINDOW, const float fc1, const float fc2);
void wsfirBP(const int N, const int WINDOW, const float fc1, const float fc2);
void genSinc(const int N, const float fc);
void wBlackman(const int N);
void wHanning(const int N);
void wHamming(const int N);
void wBlackmanHarris(const int N);
float retCoe(const int N);
// Generate lowpass filter
//
// This is done by generating a sinc function and then windowing it
void wsfirLP(const int N,		// size of the filter (number of taps)
			 const int WINDOW,	// window function (W_BLACKMAN, W_HANNING, etc.)
			 const float fc)	// cutoff frequency
{
	int i;

	// 1. Generate Sinc function
	genSinc(N, fc);

	// 2. Generate Window function
	switch (WINDOW) {
		case 1:	// W_BLACKMAN
			wBlackman(N);
			break;
		case 2:		// W_HANNING
			wHanning(N);
			break;
		case 3:		// W_HAMMING
			wHamming(N);
			break;
		case 4:		// W_BLACMAN_HARRIS
			wBlackmanHarris(N);
			break;
		default:
			break;
	}

	// 3. Make lowpass filter
	for (i = 0; i < N; i++) {
		FilterOut[i] = SincFc[i] * iwAuthor[i];
	}


	return;
}

// Generate highpass filter
//
// This is done by generating a lowpass filter and then spectrally inverting it
void wsfirHP(const int N,		// size of the filter
			 const int WINDOW,	// window function (W_BLACKMAN, W_HANNING, etc.)
			 const float fc)	// cutoff frequency
{
	int i;

	// 1. Generate lowpass filter
	wsfirLP(N, WINDOW, fc);

	// 2. Spectrally invert (negate all samples and add 1 to center sample) lowpass filter
	// = delta[n-((N-1)/2)] - h[n], in the time domain
	for (i = 0; i < N; i++) {
		FilterOut[i] *= -1.0;	// = 0 - h[i]
	}
	FilterOut[(N-1)/2] += 1.0;	// = 1 - h[(N-1)/2]

	return;
}

// Generate bandstop filter
//
// This is done by generating a lowpass and highpass filter and adding them
void wsfirBS(const int N,		// size of the filter
			 const int WINDOW,	// window function (W_BLACKMAN, W_HANNING, etc.)
			 const float fc1,	// low cutoff frequency
			 const float fc2)	// high cutoff frequency
{
	int i;
	float h1[2048];
	float h2[2048];

	// 1. Generate lowpass filter at first (low) cutoff frequency
	wsfirLP(N, WINDOW, fc1);
	for (i=0; i<2048;i++) {
		h1[i]=FilterOut[i];
	}
	// 2. Generate highpass filter at second (high) cutoff frequency
	wsfirHP(N, WINDOW, fc2);
	for (i=0; i<2048;i++) {
		h2[i]=FilterOut[i];
	}
	// 3. Add the 2 filters together
	for (i = 0; i < N; i++) {
		FilterOut[i] = h1[i] + h2[i];
	}

	return;
}

// Generate bandpass filter
//
// This is done by generating a bandstop filter and spectrally inverting it
void wsfirBP(const int N,		// size of the filter
			 const int WINDOW,	// window function (W_BLACKMAN, W_HANNING, etc.)
			 const float fc1,	// low cutoff frequency
			 const float fc2)	// high cutoff frequency
{
	int i;

	// 1. Generate bandstop filter
	wsfirBS(N, WINDOW, fc1, fc2);

	// 2. Spectrally invert bandstop (negate all, and add 1 to center sample)
	for (i = 0; i < N; i++) {
		FilterOut[i] *= -1.0;	// = 0 - h[i]
	}
	FilterOut[(N-1)/2] += 1.0;	// = 1 - h[(N-1)/2]

	return;
}

// Generate sinc function - used for making lowpass filter
void genSinc(const int N,		// size (number of taps)
			 const float fc)	// cutoff frequency
{
	int i;
	const float M = N-1;
	float n;

	// Constants
	const float PI = 3.14159265358979323846;

	// Generate sinc delayed by (N-1)/2
	for (i = 0; i < N; i++) {
		if (i == M/2.0) {
			SincFc[i] = 2.0 * fc;
		}
		else {
			n = (float)i - M/2.0;
			SincFc[i] = sinf(2.0*PI*fc*n) / (PI*n);
		}
	}

	return;
}

// Generate window function (Blackman)
void wBlackman(const int N)	// size of the window
{
	int i;
	const float M = N-1;
	const float PI = 3.14159265358979323846;

	for (i = 0; i < N; i++) {
		iwAuthor[i] = 0.42 - (0.5 * cosf(2.0*PI*(float)i/M)) + (0.08*cosf(4.0*PI*(float)i/M));
	}

	return;
}
// Generate window function (Hamming)
void wHamming(const int N)		// size of the window
{
	int i;
	const float M = N-1;
	const float PI = 3.14159265358979323846;

	for (i = 0; i < N; i++) {
		iwAuthor[i] = 0.54 - (0.46*cosf(2.0*PI*(float)i/M));
	}

	return;
}

// Generate window function (Hanning)
void wHanning(const int N)		// size of the window
{
	int i;
	const float M = N-1;
	const float PI = 3.14159265358979323846;

	for (i = 0; i < N; i++) {
		iwAuthor[i] = 0.5 * (1.0 - cosf(2.0*PI*(float)i/M));
	}

	return;
}
// Blackman–Harris window
void wBlackmanHarris(const int N)
{
	int i;
    const float M = N-1;
	const float PI = 3.14159265358979323846;

    for(i=0;i<N;i++) {
        iwAuthor[i] = 0.35875-(0.48829*cosf((2.0*PI*i)/M ))+(0.14128*cosf((4.0*PI*i)/M))-(0.01168*cosf((6.0*PI*i)/M));
    }
    return ;
}

// Return specified coef
 float retCoe(const int N) {
	 float sub = FilterOut[N]*65536;
	 //int sub = 32768;
	 return sub;
 }


#endif /* WSFIR_H_ */
