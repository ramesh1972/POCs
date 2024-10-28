using edu.stanford.nlp.ie.crf;
using java.util;

class Program
{
    static void Main()
    {
        // Path to the folder with models
        var segmenterData = @"stanford-segmenter-2020-11-17\data\";
        var sampleData = @".\stanford-segmenter-2020-11-17\test.simp.utf8";

        // This is a very simple demo of calling the Chinese Word Segmenter programmatically.
        // It assumes an input file in UTF8. This will run correctly in the distribution home
        // directory. To run in general, the properties for where to find dictionaries or
        // normalizations have to be set.
        // @author Christopher Manning

        // Setup Segmenter loading properties
        var props = new Properties();
        props.setProperty("sighanCorporaDict", segmenterData);
        // Lines below are needed because CTBSegDocumentIteratorFactory accesses it
        props.setProperty("serDictionary", segmenterData + @"\dict-chris6.ser.gz");
        props.setProperty("testFile", sampleData);
        props.setProperty("inputEncoding", "UTF-8");
        props.setProperty("sighanPostProcessing", "true");

        // Load Word Segmenter
        var segmenter = new CRFClassifier(props);
        segmenter.loadClassifierNoExceptions(segmenterData + @"\ctb.gz", props);
        segmenter.classifyAndWriteAnswers(sampleData);
    }
}