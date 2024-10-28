<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<script language="vbscript">
    Dim x
    Dim y
    Dim z
    Dim w
    Dim u
    Dim v
    Dim zz
    Dim i, j, n, k
    Dim strName, strMembers 


    'Get information from type library
    Set x = TypeLibInfoFromFile("D:\Projects\mac-web\Mac_RBW\BMC\mac.tlb")
    Set y = x.CoClasses

    'Show Type Library information in the List box
    For i = 1 To y.Count
        If i <> 1 Then
            strName = ""
            Response.write  strName
        End If
        strName = "Class Name: " & y.Item(i).Name
        Response.write  strName
        Set z = y.Item(i).Interfaces
        For n = 1 To z.Count
            Set w = z.Item(n).Members
            For k = 1 To w.Count
                Set u = w.Item(k)
                strMembers = "      Member: " & u.Name
                Response.write  strMembers
                
                Set v = u.Parameters
                For l = 1 To v.Count
                    Set zz = v.Item(l)
                    Dim yy
                    Set yy = zz.CustomDataCollection
                    Response.write  ("               " & zz.Name & " Type = " & zz.VarTypeInfo.VarType)
                    For m = 1 To yy.Count
                        Dim xx
                        Set xx = yy.Item(m)
                        Response.write  ("                            " & xx.Guid & " Value = " & xx.Value)
                    Next
                Next
            Next
        Next
    Next
    Set z = Nothing
    Set y = Nothing
    Set x = Nothing
    Set w = Nothing
</script>

</BODY>
</HTML>
