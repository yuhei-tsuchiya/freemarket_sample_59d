document.addEventListener("DOMContentLoaded", function(){
  var count = 0
  var dropZone = document.getElementById("item-drop-zone");

  dropZone.addEventListener("dragover", function(e) {
    e.stopPropagation();
    e.preventDefault();
    
    this.style.background = "#eee";
  }, false);

  dropZone.addEventListener("dragleave", function(e) {
    e.stopPropagation();
    e.preventDefault();
    
    this.style.background = "#ffffff";
  }, false);

  dropZone.addEventListener("drop", function(e) {
    e.stopPropagation();
    e.preventDefault();

    this.style.background = "#ffffff";

    
    var files = e.dataTransfer.files;
    for (var i = 0; i < files.length; i++) {
      (function() {
        var fr = new FileReader();
        fr.onload = function() {

          // プレビューを追加するdivを取得
          var target_ul = $("#item-append-target");

          //追加するhtml-liを生成
          var html = `<li class="contents-item__container__uploadbox__zone-item__have-item--upload-item">
          <figure class="contents-item__container__uploadbox__zone-item__have-item--upload-figure">
          <img alt="test" src="${fr.result}" class="contents-item__container__uploadbox__zone-item__have-item--upload-image">
          </figure>
          <div class="contents-item__container__uploadbox__zone-item__have-item__upload-btnbox">
          <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn">　</a>
          <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn btn-left" href="#">削除</a>
          </div>
          </li>`;

          // append
          target_ul.append(html);
          count += 1
          if (count >= 5) {
              // ドラッグアンドドロップのlabelを削除
              $("#item-drop-zone").css('display','none');
          }          
        };
        fr.readAsDataURL(files[i]);
      })();
      
    }
  }, false);
})
  
