<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<html>
<head>

    <title>File browser</title>
    
    <script src="/static/js/jquery.treeview.pack.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/static/css/jquery.treeview.css" type="text/css" />

<script type="text/javascript">
// <!--

var rootFolder;

$(document).ready(function(){
    initJSONRpc(loadFolderTree);
});

function loadFolderTree() {
    folderService.getTree(function(rootItem) {
        rootFolder = rootItem;
        $("#folders-tree").html(renderFolderList(rootItem));        
       	$("#folders-tree").treeview();
    });
}

/**
 * Render ul/li list for folder item and subitems.
 * @param item - java class TreeItemDecorator<FolderEntity>
 */
function renderFolderList(item) {
   	var titleLink = "<a href=\"#\" onclick=\"onFolderSelected('" 
        	+ item.entity.id + "')\">" + item.entity.title
       	    + "</a>";
    var s = "<li>" + titleLink;
    if (item.children.list.length > 0) {
        s += "<ul>\n";
        for (var i = 0; i < item.children.list.length; i++) {
            var childItem = item.children.list[i];
            s += renderFolderList(childItem);
        }
        s += "</ul>\n";
    }
    s += "</li>\n"
    return s;
}

function onFolderSelected(folderId) {
    folderService.getFolderPath(function(folderPath) {
        fileService.getByFolder(function(files) {
            var result = "";
            for (i = 0; i < files.list.length; i++) {
                var file = files.list[i];
                var title = " title=\"" + file.title + "\"";
                var onClick = " onclick=\"onFileSelected('" + file.id + "')\"";
                var thumbnail = '';
                if (isImage(file.filename)) {
                    thumbnail = '<img width="160" height="120" src="/file' 
                        + folderPath + '/' + file.filename + '" />';
                }
                result += "<li><div class=\"file-border\"" + onClick 
                    + title 
                    + "><div class=\"file-thumbnail\">" + thumbnail 
                    + "</div>" + file.filename 
                    + "</div></li>\n";
            }
            $("#files").html(result);            	
        }, folderId);    
    }, folderId);
}

function onFileSelected(fileId) {
    jsonrpc.fileService.getFilePath(function(path) {
       	window.opener.CKEDITOR.tools.callFunction(1, path);
        window.close();                
    }, fileId);
} 

//-->
</script>

</head>
<body>

<div class="browser-folders">
    <ul id="folders-tree">
    </ul>
</div>
<div class="browser-files">
    <ul id="files">
    </ul>
    <div class="clear"> </div>
</div>

</body>
</html>