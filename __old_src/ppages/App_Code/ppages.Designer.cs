﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Data.EntityClient;
using System.ComponentModel;
using System.Xml.Serialization;
using System.Runtime.Serialization;

[assembly: EdmSchemaAttribute()]

namespace ppagesModel
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class PPagesEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new PPagesEntities object using the connection string found in the 'PPagesEntities' section of the application configuration file.
        /// </summary>
        public PPagesEntities() : base("name=PPagesEntities", "PPagesEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new PPagesEntities object.
        /// </summary>
        public PPagesEntities(string connectionString) : base(connectionString, "PPagesEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new PPagesEntities object.
        /// </summary>
        public PPagesEntities(EntityConnection connection) : base(connection, "PPagesEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<tab> tabs
        {
            get
            {
                if ((_tabs == null))
                {
                    _tabs = base.CreateObjectSet<tab>("tabs");
                }
                return _tabs;
            }
        }
        private ObjectSet<tab> _tabs;

        #endregion
        #region AddTo Methods
    
        /// <summary>
        /// Deprecated Method for adding a new object to the tabs EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddTotabs(tab tab)
        {
            base.AddObject("tabs", tab);
        }

        #endregion
    }
    

    #endregion
    
    #region Entities
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="ppagesModel", Name="tab")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class tab : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new tab object.
        /// </summary>
        /// <param name="tabid">Initial value of the tabid property.</param>
        public static tab Createtab(global::System.Int32 tabid)
        {
            tab tab = new tab();
            tab.tabid = tabid;
            return tab;
        }

        #endregion
        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 tabid
        {
            get
            {
                return _tabid;
            }
            set
            {
                if (_tabid != value)
                {
                    OntabidChanging(value);
                    ReportPropertyChanging("tabid");
                    _tabid = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("tabid");
                    OntabidChanged();
                }
            }
        }
        private global::System.Int32 _tabid;
        partial void OntabidChanging(global::System.Int32 value);
        partial void OntabidChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.Int32> parenttabid
        {
            get
            {
                return _parenttabid;
            }
            set
            {
                OnparenttabidChanging(value);
                ReportPropertyChanging("parenttabid");
                _parenttabid = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("parenttabid");
                OnparenttabidChanged();
            }
        }
        private Nullable<global::System.Int32> _parenttabid;
        partial void OnparenttabidChanging(Nullable<global::System.Int32> value);
        partial void OnparenttabidChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String tabtext
        {
            get
            {
                return _tabtext;
            }
            set
            {
                OntabtextChanging(value);
                ReportPropertyChanging("tabtext");
                _tabtext = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("tabtext");
                OntabtextChanged();
            }
        }
        private global::System.String _tabtext;
        partial void OntabtextChanging(global::System.String value);
        partial void OntabtextChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String backcolor
        {
            get
            {
                return _backcolor;
            }
            set
            {
                OnbackcolorChanging(value);
                ReportPropertyChanging("backcolor");
                _backcolor = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("backcolor");
                OnbackcolorChanged();
            }
        }
        private global::System.String _backcolor;
        partial void OnbackcolorChanging(global::System.String value);
        partial void OnbackcolorChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public Nullable<global::System.Int32> pagetypeid
        {
            get
            {
                return _pagetypeid;
            }
            set
            {
                OnpagetypeidChanging(value);
                ReportPropertyChanging("pagetypeid");
                _pagetypeid = StructuralObject.SetValidValue(value);
                ReportPropertyChanged("pagetypeid");
                OnpagetypeidChanged();
            }
        }
        private Nullable<global::System.Int32> _pagetypeid;
        partial void OnpagetypeidChanging(Nullable<global::System.Int32> value);
        partial void OnpagetypeidChanged();

        #endregion
    
    }

    #endregion
    
}