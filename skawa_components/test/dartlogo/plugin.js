CKEDITOR.plugins.add('dartlogo',
    {
        requires: ['iframedialog'],
        init: function (editor) {
            var pluginName = 'dartlog';
            var mypath = this.path;
            editor.ui.addButton(
                'dartlogo.btn',
                {
                    label: "Dart logo inserted",
                    command: 'dartlogo.cmd',
                    icon: mypath + 'dartlogo.png'
                }
            );
            var cmd = editor.addCommand('dartlogo.cmd', {exec: showDialogPlugin});
        }
    }
);

function showDialogPlugin(editor) {
    var imageElement = editor.document.createElement('img');
    imageElement.setAttribute("src", 'dartlogo/dartlogo.png');
    editor.insertElement(imageElement);
}