//===============================================================================
// Microsoft patterns & practices Enterprise Library
// Core
//===============================================================================
// Copyright � Microsoft Corporation.  All rights reserved.
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY
// OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE.
//===============================================================================

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Resources;
using System.Text;

#if !NUNIT
using Microsoft.VisualStudio.TestTools.UnitTesting;
#else
using NUnit.Framework;
using TestClass = NUnit.Framework.TestFixtureAttribute;
using TestInitialize = NUnit.Framework.SetUpAttribute;
using TestCleanup = NUnit.Framework.TearDownAttribute;
using TestMethod = NUnit.Framework.TestAttribute;
#endif

namespace Microsoft.Practices.EnterpriseLibrary.Common.Tests
{
    [TestClass]
    public class StringTranslatorFixture
    {
        [TestMethod]
        public void ReturnsTranslatedStringForGivenResourceAndLabel()
        {
            StringTranslator translator = new StringTranslator();
            ResourceManager manager = new ResourceManager(
                                    "Microsoft.Practices.EnterpriseLibrary.Common.Tests.Properties.Resources",
                                    Assembly.GetExecutingAssembly());
            Assert.AreEqual("Foo Text", translator.Translate(manager, "FooLabel"));
        }
        
        [TestMethod]
        public void ReturnsNullIfLabelCannotBeFound()
        {
            StringTranslator translator = new StringTranslator();
            ResourceManager manager = new ResourceManager(
                                    "Microsoft.Practices.EnterpriseLibrary.Common.Tests.Properties.Resources",
                                    Assembly.GetExecutingAssembly());
            Assert.IsNull(translator.Translate(manager, "UnknownLabel"));
        }
        
        [TestMethod, ExpectedException(typeof(MissingManifestResourceException))]
        public void ExceptionThrownIfResourcesCannotBeFound()
        {
            StringTranslator translator = new StringTranslator();
            ResourceManager manager = new ResourceManager(
                                    "UnknownResources",
                                    Assembly.GetExecutingAssembly());
            Assert.IsNull(translator.Translate(manager, "UnknownLabel"));
        }
    }
    
    public class StringTranslator
    {
        public string Translate(ResourceManager manager, string resourceLabel)
        {
            return manager.GetString(resourceLabel);
        }
    }
}
