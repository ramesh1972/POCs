using Azure.AI.OpenAI;
using System.Text;

OpenAIClient client = new OpenAIClient("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");

// get teh embeddings for the txt
string deploymentOrModelName = "text-embedding-ada-002";
var embeddingsOptions = new EmbeddingsOptions()
{
    DeploymentName = deploymentOrModelName,
    Input = { "Your sample text for which you need vectors (embeddings)" },
};

Embeddings response = client.GetEmbeddings(embeddingsOptions);

// print the embeddings
EmbeddingItem firstItem = response.Data[0];

float[] floatArray = firstItem.Embedding.ToArray();
foreach (float f in floatArray)
{
    Console.WriteLine(f);
}