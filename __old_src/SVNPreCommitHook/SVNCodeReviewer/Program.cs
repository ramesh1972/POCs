//-----------------------------------------------------------------------
// <copyright file="Program.cs" company="SVNStyleCop">
//     Copyright (c) SVNStyleCop. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------
namespace SVNStyleCop
{
    using System;
    using System.Collections.Generic;
    using System.Configuration;
    using System.Diagnostics;
    using System.IO;
    using System.Reflection;
    using System.Text;
    using System.Text.RegularExpressions;
    using StyleCop;
    using CommandLine;

    /// <summary>
    /// Program main class. Implements the SVNStyleCop engine.
    /// </summary>
    public class Program
    {
        /// <summary>
        /// Configuration section "svnStyleCopConfig" from the App.config file.
        /// </summary>
        private static SvnStyleCopConfigSection configSection;

        /// <summary>
        /// Unique ID of the current instance. Used to create a unique temporary directory.
        /// </summary>
        private static Guid instanceId;

        /// <summary>
        /// All config files found while traversing through the repository.
        /// Used as a cache, so we don't have to search the config for every file.
        /// </summary>
        private static Dictionary<string, string> styleCopConfigs = new Dictionary<string, string>(StringComparer.InvariantCultureIgnoreCase);

        private static void WriteLogLine(string msg)
        {
            File.AppendAllText(@"c:\Temp\LogFile.txt", msg);
            File.AppendAllText(@"c:\Temp\LogFile.txt", Environment.NewLine);
        }

        public class Options
        {
            [Option("repository", Required = false, HelpText = "Repository.")]
            public string Repository { get; set; }

            [Option("revision", Required = false, HelpText = "Revision.")]
            public string Revision { get; set; }

            [Option("transaction", Required = false, HelpText = "Transaction.")]
            public string Transaction { get; set; }

            [Option("settings", Required = false, HelpText = "Settings.")]
            public string Settings { get; set; }

            [Option("author", Required = false, HelpText = "Author.")]
            public string Author { get; set; }
        }

        /// <summary>
        /// Main method.
        /// </summary>
        /// <param name="args">Command line arguments</param>
        /// <returns>
        /// 0 if successful, negative values for general errors; positive values indicate the number of violations found
        /// </returns>
        public static int Main(string[] args)
        {
            if (File.Exists(@"c:\Temp\LogFile.txt"))
                File.Delete(@"c:\Temp\LogFile.txt");
            WriteLogLine("Started...");

            for (int i = 0; i < args.Length; i++)
            {
                if (args[i] == "repository")
                    args[i] = "--" + args[i];

                if (args[i] == "transaction")
                    args[i] = "--" + args[i];

                if (args[i] == "revision")
                    args[i] = "--" + args[i];

                if (args[i] == "settings")
                    args[i] = "--" + args[i];

                if (args[i] == "author")
                    args[i] = "--" + args[i];

                WriteLogLine(args[i]);
            }

            CommandLine.ParserResult<Options> Args = Parser.Default.ParseArguments<Options>(args);

            // Command line parsing
            string rv = "";
            string t = "";
            string s = "";
            string a = "";

            string r = Args.Value.Repository.ToString();
            if (Args.Value.Revision != null)
                rv = Args.Value.Revision.ToString();

            if (Args.Value.Transaction != null)
                t = Args.Value.Transaction.ToString();

            if (Args.Value.Settings != null)
                s = Args.Value.Settings.ToString();

            if (Args.Value.Author != null)
                a = Args.Value.Author.ToString();

            if (String.IsNullOrEmpty(r) || !(!String.IsNullOrEmpty(rv) || !String.IsNullOrEmpty(t) || !String.IsNullOrEmpty(a)))
            {
                WriteLogLine("Exiting");
                PrintUsage();
                return -1;
            }

            WriteLogLine("Checked Args");
            WriteLogLine("Author = " + a);

            configSection = (SvnStyleCopConfigSection)ConfigurationManager.GetSection("svnStyleCopConfig");
            instanceId = Guid.NewGuid();

            Dictionary<string, List<string>> localSourceFiles = new Dictionary<string, List<string>>();

            SaveCommittedFilesToTemp(localSourceFiles, r, rv, t);

            string settingsFileOverride = string.Empty;
            if (!String.IsNullOrEmpty(s))
            {
                settingsFileOverride = s;
            }

            List<Violation> violations = ValidateCommittedFiles(localSourceFiles, settingsFileOverride);

            DeleteTempFoler();

            if (violations.Count > configSection.StyleCop.MaxViolationCount)
            {
                Console.Error.WriteLine("Only first {0} of total {1} violations reported below", configSection.StyleCop.MaxViolationCount, violations.Count);
            }
            else
            {
                Console.Error.WriteLine("{0} violations found", violations.Count);
            }

            for (int i = 0; i < (violations.Count > configSection.StyleCop.MaxViolationCount ? configSection.StyleCop.MaxViolationCount : violations.Count); i++)
            {
                Violation violation = violations[i];
                Console.Error.WriteLine("{0}: {1} in {3}:{2}", violation.Rule.CheckId, violation.Message, violation.Line, violation.SourceCode.Name);
            }

            return violations.Count;
        }

        /// <summary>
        /// Gets all files of the current transaction from the repository and stores them in the temporary directory.
        /// </summary>
        /// <param name="localSourceFiles">Output: mapping of StyleCop config file to files to be checked with that file.</param>
        /// <param name="repositoryPath">path of the repository on the local disk.</param>
        /// <param name="revision">revision number provided by SVN</param>
        /// <param name="transaction">transaction number provided by SVN</param>
        private static void SaveCommittedFilesToTemp(Dictionary<string, List<string>> localSourceFiles, string repositoryPath, string revision, string transaction)
        {
            ProcessStartInfo svnLookPsi = new ProcessStartInfo(configSection.SvnLook.Location);
            svnLookPsi.UseShellExecute = svnLookPsi.ErrorDialog = false;
            svnLookPsi.RedirectStandardOutput = true;
            Process svnLookProcess = new Process();
            svnLookProcess.StartInfo = svnLookPsi;

            string revOrTran = !string.IsNullOrEmpty(revision) ? string.Format("-r {0}", revision) : string.Format("-t {0}", transaction);
            svnLookPsi.Arguments = string.Format("changed \"{0}\" {1}", repositoryPath, revOrTran);

            svnLookProcess.Start();

            string[] committedFiles = svnLookProcess.StandardOutput.ReadToEnd().Split(new[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            foreach (string commitedFile in committedFiles)
                WriteLogLine(commitedFile);

            Regex fileNameExtractor = new Regex("^[AU] *(.*)");
            string tempFolder = GetTempFolderName();
            WriteLogLine("temp folder = " + tempFolder);

            foreach (string committedRow in committedFiles)
            {
                string committedFile = fileNameExtractor.Match(committedRow).Groups[1].Value;
                if (NeedToAnalyzeFile(committedFile))
                {
                    WriteLogLine("Pattern Matched");
                    string user = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
                    WriteLogLine("User=" + user);

                    string outFileName = Path.Combine(tempFolder, committedFile);
                    WriteLogLine("before directory creation");
                    Directory.CreateDirectory(Path.GetDirectoryName(outFileName));
                    WriteLogLine("directory created");

                    svnLookPsi.Arguments = string.Format("cat \"{0}\" \"{1}\" {2}", repositoryPath, committedFile, revOrTran);

                    svnLookProcess.Start();

                    StreamWriter outFile = new StreamWriter(outFileName, false, Encoding.UTF8);
                    outFile.Write(svnLookProcess.StandardOutput.ReadToEnd());
                    outFile.Close();

                    string settings = FindStyleCopSettings(committedFile, repositoryPath, revOrTran);
                    List<string> files;
                    if (!localSourceFiles.TryGetValue(settings, out files))
                    {
                        files = new List<string>();
                        localSourceFiles.Add(settings, files);
                    }

                    files.Add(outFileName);
                }
            }
        }

        /// <summary>
        /// Traverses through the repository and searches for a StyleCop.Settings file.
        /// </summary>
        /// <param name="committedFile">File to search the settings for</param>
        /// <param name="repositoryPath">path of the repository on the local disk.</param>
        /// <param name="revOrTran">argument to SvnLook cat command</param>
        /// <returns>the name of the local temporary file containing the settings or an empty string if no settings were found</returns>
        private static string FindStyleCopSettings(string committedFile, string repositoryPath, string revOrTran)
        {
            string filePath = Path.GetDirectoryName(committedFile);

            ProcessStartInfo svnLookPsi = new ProcessStartInfo(configSection.SvnLook.Location);
            svnLookPsi.UseShellExecute = svnLookPsi.ErrorDialog = false;
            svnLookPsi.RedirectStandardOutput = true;
            svnLookPsi.RedirectStandardError = true;
            Process svnLookProcess = new Process();
            svnLookProcess.StartInfo = svnLookPsi;

            while (filePath != null && filePath.Length > 1)
            {
                string settingsFile = filePath.Replace('\\', '/') + "/" + Settings.DefaultFileName;
                WriteLogLine(settingsFile);
                string foundSettingsFile;
                if (styleCopConfigs.TryGetValue(settingsFile, out foundSettingsFile))
                {
                    WriteLogLine(foundSettingsFile);
                    return foundSettingsFile;
                }

                svnLookPsi.Arguments = string.Format(
                    "cat \"{0}\" \"{1}\" {2}", repositoryPath, settingsFile, revOrTran);

                svnLookProcess.Start();
                svnLookProcess.WaitForExit();

                if (svnLookProcess.ExitCode == 0)
                {
                    ////Console.Error.WriteLine("Found config {0} for {1}", settingsFile, committedFile);
                    foundSettingsFile = Path.Combine(GetTempFolderName(), Guid.NewGuid() + ".Settings");
                    StreamWriter outFile = new StreamWriter(foundSettingsFile, false, Encoding.UTF8);
                    outFile.Write(svnLookProcess.StandardOutput.ReadToEnd());
                    outFile.Close();
                    styleCopConfigs.Add(settingsFile, foundSettingsFile);
                    return foundSettingsFile;
                }
                else
                {
                    svnLookProcess.StandardError.ReadToEnd();
                }

                filePath = Path.GetDirectoryName(filePath);
            }

            return string.Empty;
        }

        /// <summary>
        /// Checks with the PathPatterns settings whether the given file should be analyzed or ignored.
        /// </summary>
        /// <param name="filePath">SVN path (inside the repository) of the file</param>
        /// <returns>true iff we have to analyze the file.</returns>
        private static bool NeedToAnalyzeFile(string filePath)
        {
            bool matches = false;

            WriteLogLine("filePath = " + filePath);

            foreach (PathPatternElement pathPattern in configSection.PathPatterns)
            {
                WriteLogLine("pattern = " + pathPattern.Value);
                if (pathPattern.ValueRegex.IsMatch(filePath))
                {
                    if (pathPattern.Ignore)
                    {
                        return false;
                    }

                    matches = true;
                }
            }

            return matches;
        }

        /// <summary>
        /// Validates all files with StyleCop.
        /// </summary>
        /// <param name="localSourceFiles">mapping of StyleCop config file to files to be checked with that file.</param>
        /// <param name="settingsFileOverride">the command line -settings override (if it exists)</param>
        /// <returns>list of violations found in the code.</returns>
        private static List<Violation> ValidateCommittedFiles(Dictionary<string, List<string>> localSourceFiles, string settingsFileOverride)
        {
            string settingsFile = settingsFileOverride;
            if (!string.IsNullOrEmpty(settingsFile))
            {
                if (!Path.IsPathRooted(settingsFile))
                {
                    settingsFile = GetPathInExeFolder(settingsFile);
                    WriteLogLine("settings File = " + settingsFile);
                }
            }

            // If a settings file has been specified and doesn't exist, it should fall back on the default settings file
            if (string.IsNullOrEmpty(settingsFile) || !File.Exists(settingsFile))
            {
                settingsFile = configSection.StyleCop.SettingsFile;

                if (!Path.IsPathRooted(settingsFile))
                {
                    settingsFile = GetPathInExeFolder(settingsFile);
                    WriteLogLine("settings FIle 2 =" + settingsFile);
                }
            }

            List<Violation> violations = new List<Violation>();

            StyleCopConsole console = new StyleCopConsole(settingsFile, false, null, null, true, null);
            List<CodeProject> projects = new List<CodeProject>();
            foreach (KeyValuePair<string, List<string>> config in localSourceFiles)
            {
                StyleCop.Configuration configuration = new StyleCop.Configuration(new string[0]);
                CodeProject project = new CodeProject(string.Empty.GetHashCode(), string.Empty, configuration);

                if (!string.IsNullOrEmpty(config.Key))
                {
                    project.Settings = console.Core.Environment.GetSettings(config.Key, true);
                }

                projects.Add(project);

                foreach (string s in config.Value)
                {
                    console.Core.Environment.AddSourceCode(project, s, null);
                }
            }

            console.ViolationEncountered += (sender, e) => violations.Add(e.Violation);
            console.Start(projects, true);

            return violations;
        }

        /// <summary>
        /// Delete the temporary folder.
        /// </summary>
        private static void DeleteTempFoler()
        {
            string tempPath = GetTempFolderName();
            if (Directory.Exists(tempPath))
            {
                try
                {
                    // Delete the temp directory and all associated files
                    // Catch and swallow all documented thrown exceptions from this in order to
                    // prevent disturbing the committer with a clean up task failure
                    Directory.Delete(tempPath, true);
                }
                catch (IOException)
                {
                }
                catch (UnauthorizedAccessException)
                {
                }
                catch (ArgumentException)
                {
                }
            }
        }

        /// <summary>
        /// Get the full path of a file in the folder of this application.
        /// </summary>
        /// <param name="fileName">name of the file.</param>
        /// <returns>the full path of the file.</returns>
        private static string GetPathInExeFolder(string fileName)
        {
            return Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), fileName);
        }

        /// <summary>
        /// Get the temporary folder for this instance.
        /// </summary>
        /// <returns>the full path of the folder.</returns>
        private static string GetTempFolderName()
        {
            string tempRoot = Path.IsPathRooted(configSection.TempFolder) ? configSection.TempFolder : GetPathInExeFolder(configSection.TempFolder);
            return Path.Combine(tempRoot, instanceId.ToString());
        }

        /// <summary>
        /// Print the usage.
        /// </summary>
        private static void PrintUsage()
        {
            Console.WriteLine("Utility to analyze source code files from SVN using StyleCop. Version {0}", "1.0");
            Console.WriteLine("Copyright (c) Binecs 2009 http://www.binecs.com/");
            Console.WriteLine();
            Console.WriteLine("Usage: {0} [switches]", Path.GetFileName(Assembly.GetExecutingAssembly().Location));
            Console.WriteLine("   -repository:    Path to SVN repository");
            Console.WriteLine("     -revision:    SVN revision number");
            Console.WriteLine("  -transaction:    SVN transaction name");
            Console.WriteLine("     -settings:	  SVN settings file to override default (optional; falls back to default file if it does not exist)");
            Console.WriteLine("     -author:	  SVN Commit author name");
            Console.WriteLine();
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("ERROR: repository and one of transaction or revision must be specified");
            Console.ResetColor();
        }
    }
}
