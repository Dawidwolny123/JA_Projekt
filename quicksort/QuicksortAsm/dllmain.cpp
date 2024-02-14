// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"
#include <algorithm>

extern "C" __declspec(dllexport) void __stdcall QuicksortAsm(int* array, int arraySize);

int partition(int* array, int start, int end)
{
   int pivot = array[start];

   int count = 0;
   for (int i = start + 1; i <= end; i++)
   {
      if (array[i] <= pivot)
         count++;
   }

   int pivotIndex = start + count;
   std::swap(array[pivotIndex], array[start]);

   int i = start, j = end;

   while (i < pivotIndex && j > pivotIndex)
   {
      while (array[i] <= pivot)
      {
         i++;
      }

      while (array[j] > pivot)
      {
         j--;
      }

      if (i < pivotIndex && j > pivotIndex)
      {
         std::swap(array[i++], array[j--]);
      }
   }

   return pivotIndex;
}

void quicksort(int* array, int start, int end)
{
   if (start >= end)
   {
      return;
   }

   int pivot = partition(array, start, end);

   quicksort(array, start, pivot - 1);
   quicksort(array, pivot + 1, end);
}

extern "C" __declspec(dllexport) void __stdcall QuicksortCpp(int* array, int arraySize)
{
   quicksort(array, 0, arraySize - 1);
}

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

