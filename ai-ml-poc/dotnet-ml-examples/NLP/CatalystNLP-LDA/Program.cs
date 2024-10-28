﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Catalyst;
using Catalyst.Models;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Console;
using Mosaik.Core;

namespace Catalyst.Samples
{
    class Program
    {
        static async Task Main(string[] args)
        {

            Console.OutputEncoding = Encoding.UTF8;
            ApplicationLogging.SetLoggerFactory(LoggerFactory.Create(lb => lb.AddConsole()));

            //Need to register the languages we want to use first
            Catalyst.Models.English.Register();

            //Configures the model storage to use the local folder ./catalyst-models/
            Storage.Current = new DiskStorage("catalyst-models");

            //Download the Reuters corpus if necessary
            //var (train, test) = await Corpus.Reuters.GetAsync();

            //Parse the documents using the English pipeline, as the text data is untokenized so far
            var nlp = await Pipeline.ForAsync(Language.English);

            var doc = new Document("The quick brown fox jumps over the lazy dog", Language.English);
            nlp.ProcessSingle(doc);

            Console.WriteLine(doc.ToJson());
        }
    }
}
