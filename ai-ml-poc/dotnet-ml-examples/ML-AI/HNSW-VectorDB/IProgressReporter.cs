namespace HNSW.Net.Demo
{
    public interface IProgressReporter
    {
        void Progress(int current, int total);
    }
}