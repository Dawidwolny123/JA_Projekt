using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;

namespace Quicksort
{
   public partial class Form1 : Form
   {
      public Form1()
      {
         InitializeComponent();
      }
        // Sta³e definiuj¹ce maksymaln¹ liczbê w¹tków oraz liczbê liczb w ka¿dym pliku.
        const int maxThreads = 64;
      const int numbersPerFile = 100000;
        // Œcie¿ka do biblioteki DLL zawieraj¹cej implementacje sortowania w C++ i asemblerze.
        private const string dllPath = "QuicksortAsm.dll";
        // Deklaracje metod zewnêtrznych z biblioteki DLL.
        [DllImport(dllPath)]

      private static extern void QuicksortAsm(IntPtr arrayPtr, int arraySize);

      [DllImport(dllPath)]
      private static extern void QuicksortCpp(IntPtr arrayPtr, int arraySize);
    
      private void QuicksortCs(int[] array, int arraySize)
      {
         Quicksort(array, 0, arraySize - 1);
      }
        // Metoda dziel¹ca tablicê na podtablice.
        private int Partition(int[] array, int start, int end)
      {
         int pivot = array[start];

         int count = 0;
         for (int k = start + 1; k <= end; k++)
         {
            if (array[k] <= pivot)
               count++;
         }

         int pivotIndex = start + count;
         int tmp = array[pivotIndex];
         array[pivotIndex] = array[start];
         array[start] = tmp;

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
               tmp = array[i];
               array[i] = array[j];
               array[j] = tmp;
               i++;
               j--;
            }
         }

         return pivotIndex;
      }
        // G³ówna metoda sortowania szybkiego.
        void Quicksort(int[] array, int start, int end)
      {
         if (start >= end)
         {
            return;
         }

         int pivot = Partition(array, start, end);

         Quicksort(array, start, pivot - 1);
         Quicksort(array, pivot + 1, end);
        }  
        // Metoda wywo³ywana przy za³adowaniu formularza.
        private void Form1_Load(object sender, EventArgs e)
      {
         comboBoxProgrammingLanguage.SelectedIndex = 0;
         textBoxThreads.Text = "4";
      }
        // Metoda obs³uguj¹ca klikniêcie przycisku "Sortuj".
        private void buttonGenerate_Click(object sender, EventArgs e)
      {
         Random random = new Random();
         if (!Directory.Exists("input"))
         {
            Directory.CreateDirectory("input");
         }

         for (int i = 0; i < maxThreads; ++i)
         {
            string fileName = $"input/file_{i}.txt";
            using (StreamWriter writer = new StreamWriter(fileName))
            {
               for (int j = 0; j < numbersPerFile; j++)
               {
                  int randomNumber = random.Next(0, numbersPerFile);
                  writer.Write($"{randomNumber} ");
               }
            }
         }
      }

        // Metoda obs³uguj¹ca klikniêcie przycisku "Sortuj".
        // Sprawdzenie poprawnoœci liczby w¹tków.
        // Wczytanie danych z plików wejœciowych.
        // Sortowanie tablic za pomoc¹ ró¿nych jêzyków programowania (C#, C++, asembler).
        // Zapisanie posortowanych danych do plików wyjœciowych.
        // Mierzenie czasu sortowania i aktualizacja interfejsu u¿ytkownika z wynikami.
        private async void buttonSort_Click(object sender, EventArgs e)
      {
         int threads;
         bool isNumeric = int.TryParse(textBoxThreads.Text.ToString(), out threads);
         if (threads < 1 || threads > maxThreads)
         {
            MessageBox.Show($"Liczba w¹tków powinna byæ z przedzia³u <1, {maxThreads}>.");
            return;
         }

         progressBar.Value = 0;

         //wczytanie liczb z plików wejœciowych
         List<int[]> arrays = new List<int[]>();
         for(int i = 0; i < threads; ++i)
         {
            string fileName = $"input/file_{i}.txt";
            if (!File.Exists(fileName))
            {
               MessageBox.Show("Pliki wejœciowe nie istniej¹! Najpierw je wygeneruj.");
               return;
            }
            string[] lines = File.ReadAllLines(fileName);
            string[] numbers = lines.SelectMany(line => line.Split(' ')).ToArray();

            int[] array = new int[numbersPerFile];

            for(int j = 0; j < numbers.Length - 1; ++j)
            {
               if (int.TryParse(numbers[j], out int parsedNumber))
               {
                  array[j] = parsedNumber;
               }
               else
               {
                  MessageBox.Show($"B³¹d podczas parsowania liczby w pliku {fileName}, liczba nr {j + 1}");
               }
            }

            arrays.Add(array);
         }

         if (!Directory.Exists("output"))
         {
            Directory.CreateDirectory("output");
         }

         Stopwatch stopWatch = Stopwatch.StartNew();
         await Sort(arrays, threads, comboBoxProgrammingLanguage.SelectedIndex);
         long elapsedMilliseconds = stopWatch.ElapsedMilliseconds;
         if (comboBoxProgrammingLanguage.SelectedIndex == 0)
         {
            labelMillisecondsCs.Text = elapsedMilliseconds.ToString() + " ms";
         }
         else if (comboBoxProgrammingLanguage.SelectedIndex == 1)
         {
            labelMillisecondsCpp.Text = elapsedMilliseconds.ToString() + " ms";
         }
         else if (comboBoxProgrammingLanguage.SelectedIndex == 2)
         {
            labelMillisecondsAsm.Text = elapsedMilliseconds.ToString() + " ms";
         }

      }

        // Metoda sortuj¹ca tablice asynchronicznie.
        private async Task Sort(List<int[]> arrays, int threads, int language)
      {
         List<Task> tasks = new List<Task>();
         double progress = 0.0;
         object lockObject = new object();
         for (int thread = 0; thread < threads; thread++)
         {
            int threadNr = thread;
            tasks.Add(Task.Run(() =>
            {
                Console.WriteLine("thread" + Thread.CurrentThread.ManagedThreadId);
               int[] array = arrays[threadNr];
               if (language == 0)
               {
                  QuicksortCs(array, array.Length);
               }
               else if (language == 1)
               {
                  IntPtr arrayPtr = Marshal.UnsafeAddrOfPinnedArrayElement(array, 0);
                  QuicksortCpp(arrayPtr, array.Length);
               }
               else if (language == 2)
               {
                  IntPtr arrayPtr = Marshal.UnsafeAddrOfPinnedArrayElement(array, 0);
                  QuicksortAsm(arrayPtr, array.Length);
               }

               string fileName = $"output/file_{threadNr}.txt";
               using (StreamWriter writer = new StreamWriter(fileName))
               {
                  for (int j = 0; j < array.Length; ++j)
                  {
                     writer.Write($"{array[j]} ");
                  }
               }

               lock (lockObject)
               {
                  progress = Math.Min(100.0, progress + 100.0 / (double)threadNr);
                  progressBar.Value = (int)progress;
               }
            }));
         }

         await Task.WhenAll(tasks);
      }
   }
}
