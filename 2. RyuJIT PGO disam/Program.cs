using System;
using System.IO;
using System.Runtime.CompilerServices;
using System.Threading;

public class P
{
    public static void Main()
    {
        for (int i = 0; i < 50; i++)
        {
            Test(3);
            Thread.Sleep(5);
        }
    }

    // optimized into a const!
    private static readonly int TotalFiles =
        Directory.GetFiles(Environment.CurrentDirectory).Length;


    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int Test(int x)
    {
        if (TotalFiles == 0)
            // this branch is eliminated since TotalFiles becomes a const in tier1
            throw new InvalidOperationException();

        if (x % 2 == 0)
            // this block becomes cold (rarely-used) so JIT can move it down
            Console.WriteLine("x is odd");

        return x * 100;
    }
}
