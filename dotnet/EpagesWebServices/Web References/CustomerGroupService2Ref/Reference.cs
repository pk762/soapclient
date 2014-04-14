//------------------------------------------------------------------------------
// <auto-generated>
//     Dieser Code wurde von einem Tool generiert.
//     Laufzeitversion:4.0.30319.18444
//
//     Änderungen an dieser Datei können falsches Verhalten verursachen und gehen verloren, wenn
//     der Code erneut generiert wird.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EpagesWebServices.CustomerGroupService2Ref {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="bind_CustomerGroup_SOAP", Namespace="urn://epages.de/WebService/CustomerGroupService/2011/03")]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TDelete_Return))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TUpdate_Return))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TUpdate_Input))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TCreate_Return))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TAttribute))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TLocalizedValue))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TCreate_Input))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TExists_Return))]
    [System.Xml.Serialization.SoapIncludeAttribute(typeof(TGetList_Return))]
    public partial class CustomerGroupService : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        /// <remarks/>
        public CustomerGroupService() {
            this.Url = "http://localhost/epages/Store.soap";
        }
        
        public CustomerGroupService(string url) {
            this.Url = url;
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapRpcMethodAttribute("urn://epages.de/WebService/CustomerGroupService/2011/03#getList", RequestNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03", ResponseNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03")]
        [return: System.Xml.Serialization.SoapElementAttribute("Aliases")]
        public TGetList_Return[] getList() {
            object[] results = this.Invoke("getList", new object[0]);
            return ((TGetList_Return[])(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BegingetList(System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("getList", new object[0], callback, asyncState);
        }
        
        /// <remarks/>
        public TGetList_Return[] EndgetList(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((TGetList_Return[])(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapRpcMethodAttribute("urn://epages.de/WebService/CustomerGroupService/2011/03#exists", RequestNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03", ResponseNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03")]
        [return: System.Xml.Serialization.SoapElementAttribute("Groups")]
        public TExists_Return[] exists(string[] Groups) {
            object[] results = this.Invoke("exists", new object[] {
                        Groups});
            return ((TExists_Return[])(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult Beginexists(string[] Groups, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("exists", new object[] {
                        Groups}, callback, asyncState);
        }
        
        /// <remarks/>
        public TExists_Return[] Endexists(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((TExists_Return[])(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapRpcMethodAttribute("urn://epages.de/WebService/CustomerGroupService/2011/03#create", RequestNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03", ResponseNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03")]
        [return: System.Xml.Serialization.SoapElementAttribute("Groups")]
        public TCreate_Return[] create(TCreate_Input[] Groups) {
            object[] results = this.Invoke("create", new object[] {
                        Groups});
            return ((TCreate_Return[])(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult Begincreate(TCreate_Input[] Groups, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("create", new object[] {
                        Groups}, callback, asyncState);
        }
        
        /// <remarks/>
        public TCreate_Return[] Endcreate(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((TCreate_Return[])(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapRpcMethodAttribute("urn://epages.de/WebService/CustomerGroupService/2011/03#update", RequestNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03", ResponseNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03")]
        [return: System.Xml.Serialization.SoapElementAttribute("Groups")]
        public TUpdate_Return[] update(TUpdate_Input[] Groups) {
            object[] results = this.Invoke("update", new object[] {
                        Groups});
            return ((TUpdate_Return[])(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult Beginupdate(TUpdate_Input[] Groups, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("update", new object[] {
                        Groups}, callback, asyncState);
        }
        
        /// <remarks/>
        public TUpdate_Return[] Endupdate(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((TUpdate_Return[])(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapRpcMethodAttribute("urn://epages.de/WebService/CustomerGroupService/2011/03#delete", RequestNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03", ResponseNamespace="urn://epages.de/WebService/CustomerGroupService/2011/03")]
        [return: System.Xml.Serialization.SoapElementAttribute("Groups")]
        public TDelete_Return[] delete(string[] Groups) {
            object[] results = this.Invoke("delete", new object[] {
                        Groups});
            return ((TDelete_Return[])(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult Begindelete(string[] Groups, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("delete", new object[] {
                        Groups}, callback, asyncState);
        }
        
        /// <remarks/>
        public TDelete_Return[] Enddelete(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((TDelete_Return[])(results[0]));
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TGetList_Return {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public TError Error;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/EpagesTypes/2005/01")]
    public partial class TError {
        
        /// <remarks/>
        public string Message;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TDelete_Return {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public bool deleted;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool deletedSpecified;
        
        /// <remarks/>
        public TError Error;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TUpdate_Return {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public string Path;
        
        /// <remarks/>
        public bool updated;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool updatedSpecified;
        
        /// <remarks/>
        public TError Error;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TUpdate_Input {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public TLocalizedValue[] Name;
        
        /// <remarks/>
        public bool IsNewMemberDefault;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool IsNewMemberDefaultSpecified;
        
        /// <remarks/>
        public bool IsNonMemberDefault;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool IsNonMemberDefaultSpecified;
        
        /// <remarks/>
        public TAttribute[] Attributes;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/EpagesTypes/2005/01")]
    public partial class TLocalizedValue {
        
        /// <remarks/>
        public string LanguageCode;
        
        /// <remarks/>
        public string Value;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/EpagesTypes/2005/01")]
    public partial class TAttribute {
        
        /// <remarks/>
        public string Name;
        
        /// <remarks/>
        public string Value;
        
        /// <remarks/>
        public TLocalizedValue[] LocalizedValues;
        
        /// <remarks/>
        public string Type;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TCreate_Return {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public string Path;
        
        /// <remarks/>
        public bool created;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool createdSpecified;
        
        /// <remarks/>
        public TError Error;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TCreate_Input {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public TLocalizedValue[] Name;
        
        /// <remarks/>
        public bool IsNewMemberDefault;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool IsNewMemberDefaultSpecified;
        
        /// <remarks/>
        public bool IsNonMemberDefault;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool IsNonMemberDefaultSpecified;
        
        /// <remarks/>
        public TAttribute[] Attributes;
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("XamarinStudio", "4.0.0.0")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.SoapTypeAttribute(Namespace="urn://epages.de/WebService/CustomerGroupTypes/2011/03")]
    public partial class TExists_Return {
        
        /// <remarks/>
        public string Alias;
        
        /// <remarks/>
        public bool exists;
        
        /// <remarks/>
        [System.Xml.Serialization.SoapIgnoreAttribute()]
        public bool existsSpecified;
        
        /// <remarks/>
        public TError Error;
    }
}