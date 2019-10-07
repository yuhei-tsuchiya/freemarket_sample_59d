$(function() {

  // 変数定義
  var count = 0;
  var list = new DataTransfer();

  // ドラッグアンドドロップ枠を縮める関数
  function deleteWidth(num) {
    var del = 615 - num * 115
    $(".contents-item__container__uploadbox__zone-item__dropbox").css('width', `${del}px`)
  }

  // input[type=file]に、FileListを入力する関数
  function appendFile(list) {
    if (list.files && list.files[0]) {
      var myFileList = list.files;
      document.querySelector('input[type=file]').files = myFileList;
    }
  }

  // プレビューを表示する関数
  function readURL(input, list) {
    if (input.files && input.files[0]) {
      $.each(input.files, function(index, file) {
        count += 1;
        if (count >= 6){
          count -= 1
          return false;
        }
        list.items.add(file);
        console.log(list.items)
        var reader = new FileReader();
        var target_ul = $("#item-append-target");
        reader.onload = function (e) {
          var loadedImageUri = e.target.result;
          var html = `<li class="contents-item__container__uploadbox__zone-item__have-item--upload-item">
            <figure class="contents-item__container__uploadbox__zone-item__have-item--upload-figure">
            <img alt="test" src="${loadedImageUri}" class="contents-item__container__uploadbox__zone-item__have-item--upload-image">
            </figure>
            <div class="contents-item__container__uploadbox__zone-item__have-item__upload-btnbox">
            <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn">　</a>
            <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn btn-left" href="#" data-pict="${file.name}" id="pict-delete">削除</a>
            </div>
            </li>`;

          if (count < 5) {
            deleteWidth(input.files.length)
          } else {
            $(".contents-item__container__uploadbox__zone-item__dropbox").hide()
          }
          target_ul.append(html);
        }
        reader.readAsDataURL(input.files[index]);
      })
    }
  }

  // inputタグに変化があれば発火
  $("#item-drop-zone").change(function(e){
    
    readURL(this, list);
    appendFile(list);

  });

  // 削除ボタンがクリックされたら発火
  $(document).on("click", "#pict-delete", function (e) {
    e.preventDefault();
    var target = $(e.target);
    var pict_name = target.data('pict');
    target.parent().parent().remove();
    if (document.querySelector('input[type=file]').files.length == 1){
      $('input[type="file"]').val(null);
      list.clearData();
    } else {
      $.each(list.files, function(index, file) {
        if (file.name == pict_name) {
          list.items.remove(index);
          return false
        }
      })
      appendFile(list)
    }
    
    count -= 1
    if (count == 4){
      var width = 615 - 115 * 4
      $(".contents-item__container__uploadbox__zone-item__dropbox").show()
      $(".contents-item__container__uploadbox__zone-item__dropbox").css("width", `${width}px`)
    } else {
      deleteWidth(count)
    }
  })
});

