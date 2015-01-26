// Código para uma entrada seno de offset 2V e Vpp = 10mv. Ou seja, é uma senóide de amplitude baixíssima simulando uma entrada dc de 2v.
//

#include "stdafx.h"
#include "arduino.h"
#include "windows.h"


int inPin = A1;
double voltagem = 0;
double valueIn2 = 0;
LARGE_INTEGER frequency;
LARGE_INTEGER t0, t1;
int i = 0;


int _tmain(int argc, _TCHAR* argv[])
{
    return RunArduinoSketch();
}

void setup()
{
	QueryPerformanceFrequency(&frequency);
	QueryPerformanceCounter(&t0);
	delay(1000);
	QueryPerformanceCounter(&t1);
	
}

// the loop routine runs over and over again forever:
void loop()
{
	voltagem = analogRead(inPin) * (5.0 / 1024.0);
	QueryPerformanceCounter(&t1);
	Log(L"Voltagem: %lf\n", voltagem);


	if (i == 0 && voltagem >= 0.005){
		QueryPerformanceCounter(&t0);
		voltagem = analogRead(inPin) * (5.0 / 1024.0);
		Log(L"Voltagem: %lf\n", voltagem);
		while (analogRead(inPin) * (5.0 / 1024.0) < 2 * (1 - (1 / 2.718282)));
		QueryPerformanceCounter(&t1);
		voltagem = analogRead(inPin) * (5.0 / 1024.0);
		Log(L"Voltagem: %lf\n", voltagem);
		Log("RC: %f\n", ((t1.QuadPart - t0.QuadPart)*1.0 / frequency.QuadPart));
		i = 20;
		delay(2000);
	}
	
	if (i != 0 && voltagem == 0)
	{
		i--;
	}
}
