using System;
using System.Runtime.CompilerServices;

public class P
{
    public static void Main(string[] args)
    {
        RuntimeHelpers.PrepareMethod(
            typeof(P).GetMethod("SayHelloWorld")!.MethodHandle);

        // Or just call that method directly from here (make sure it has NoInlining on top of it)
        // PrepareMethod is better because it doesn't ask you to provide all input arguments 
        // for a method, but it's not generic friendly
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static void SayHelloWorld(int x)
    {
        Console.WriteLine("Hello World: " + x);
    }
}