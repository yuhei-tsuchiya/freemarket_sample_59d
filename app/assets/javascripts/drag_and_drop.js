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






// document.addEventListener("DOMContentLoaded", function(){

//   var file    = document.querySelector('input[type=file]').files[0];//'input[type=file]'で投稿されたファイル要素の0番目を参照します。input[type=file]にmutipleがなくてもこのコードになります。
//   var reader  = new FileReader();

//   reader.addEventListener("load", function () {
//     preview.src = reader.result;//めちゃめちゃ長い文字列が引き渡されます。ユーザーのファイルパスに紐付かない画像情報だと思います。
//   }, false);

//   if (file) {
//     reader.readAsDataURL(file);//ここでreaderのメソッドに引数としてfileを入れます。ここで、readerのaddEventListenerが発火します。
//   }

    // // var preview = document.querySelector('#preview');
    // var target_ul = $("#item-append-target");
    // // var files   = document.querySelector('input[type=file]').files;
    // var file    = document.querySelector('input[type=file]').files[0];
    // console.log("hoge1")

    // function readAndPreview(file) {
    //   console.log("hoge3")
    //   // Make sure `file.name` matches our extensions criteria
    //   if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
    //     var reader = new FileReader();

    //     reader.addEventListener("load", function () {
    //       var image = new Image();
    //       image.height = 100;
    //       image.title = file.name;
    //       image.src = this.result;
    //       // preview.appendChild( image );
          
    //       var html = `<li class="contents-item__container__uploadbox__zone-item__have-item--upload-item">
    //        <figure class="contents-item__container__uploadbox__zone-item__have-item--upload-figure">
    //        <img alt="test" src="${image.src}" class="contents-item__container__uploadbox__zone-item__have-item--upload-image">
    //        </figure>
    //        <div class="contents-item__container__uploadbox__zone-item__have-item__upload-btnbox">
    //        <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn">　</a>
    //        <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn btn-left" href="#">削除</a>
    //        </div>
    //        </li>`;

    //       target_ul.append(html);
    //     }, false);

    //     reader.readAsDataURL(file);
    //   }

    // }

    // if (files) {
    //   console.log("hoge2");
    //   [].forEach.call(files, readAndPreview);
    // }
// })


// function previewFiles() {


//   var preview_array = [];
//   // var file_array = [];
//   var files   = document.querySelector('input[type=file]').files;

//   var reader_array  = [];
//   var file_length = document.querySelector('input[type=file]').files.length;
//   for(var i=0; i<3; i++){
//     document.querySelector('img[name="preview' + i + '"]').src = "";
//   }
//   for(var i=0; i<file_length; i++){
//     var html = `<li class="contents-item__container__uploadbox__zone-item__have-item--upload-item">
//     <figure class="contents-item__container__uploadbox__zone-item__have-item--upload-figure">
//     <img alt="test" src="${loadedImageUri}" class="contents-item__container__uploadbox__zone-item__have-item--upload-image">
//     </figure>
//     <div class="contents-item__container__uploadbox__zone-item__have-item__upload-btnbox">
//     <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn">　</a>
//     <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn btn-left" href="#">削除</a>
//     </div>
//     </li>`;

//     preview_array.push(document.querySelector('img[name="preview' + i + '"]'));
//     file_array.push(document.querySelector('input[type=file]').files[i]);
//     reader_array.push(new FileReader());
//   }
//   if(file_length>0){
//       console.log("0");
//       reader_array[0].addEventListener("load", function () {
//           preview_array[0].src = reader_array[0].result;
//       }, false);
//   }

//   if(file_length>1){
//       console.log("1");
//       reader_array[1].addEventListener("load", function () {
//           preview_array[1].src = reader_array[1].result;
//       }, false);
//   }

//   if(file_length>2){
//       console.log("2");
//       reader_array[2].addEventListener("load", function () {
//           preview_array[2].src = reader_array[2].result;
//       }, false);
//   }

//   for(var i=0; i<file_length; i++){
//       reader_array[i].readAsDataURL(file_array[i]);
//   }
// }



// // document.addEventListener("DOMContentLoaded", function(){
// //   var count = 0
// //   var dropZone = document.getElementById("item-drop-zone");

// //   // dropZone.addEventListener("dragover", function(e) {
// //   //   e.stopPropagation();
// //   //   e.preventDefault();
    
// //   //   this.style.background = "#eee";
// //   // }, false);

// //   // dropZone.addEventListener("dragleave", function(e) {
// //   //   e.stopPropagation();
// //   //   e.preventDefault();
    
// //   //   this.style.background = "#ffffff";
// //   // }, false);

// //   // dropZone.addEventListener("drop", function(e) {
// //   //   e.stopPropagation();
// //   //   e.preventDefault();

// //   dropZone.addEventListener("drop", function(e) {
// //     e.stopPropagation();
// //     e.preventDefault();

// // // $(function() {

// //   var count = 0
// //   // var dropZone = document.getElementById("item-drop-zone");

// //   // dropZone.addEventListener("dragover", function(e) {
// //   //     e.stopPropagation();
// //   //     e.preventDefault();
      
// //   //     this.style.background = "#eee";
// //   //   }, false);
    
// //   // dropZone.addEventListener("dragleave", function(e) {
// //   //     e.stopPropagation();
// //   //     e.preventDefault();

// //   //     this.style.background = "#ffffff";
// //   //   }, false);

// //   // var dropZone = document.getElementById("item-drop-zone");

// //   // $('#item_images_attributes_0_image').on('change', function(_e) {
// //   //   e.stopPropagation();
// //   //   e.preventDefault();
// //   //   console.log("hoge first") 

// //   //   var e = _e;
// //   //       if( _e.originalEvent ){
// //   //           e = _e.originalEvent;
// //   //       }

// //   //   var dt = e.dataTransfer;
// //   //   var files = dt.files;


// //   reader.addEventListener("load", function () {
// //     preview.src = reader.result;//めちゃめちゃ長い文字列が引き渡されます。ユーザーのファイルパスに紐付かない画像情報だと思います。
// //   }, false);

// //   if (file) {
// //     reader.readAsDataURL(file);//ここでreaderのメソッドに引数としてfileを入れます。ここで、readerのaddEventListenerが発火します。
// //   }

// //     var files = e.dataTransfer.files;
// //     for (var i = 0; i < files.length; i++) {
// //       (function() {
// //         var fr = new FileReader();
// //         fr.onload = function(e) {

// //         //   fileReader.onload = function(event) {
// //         //     var loadedImageUri = event.target.result;
// //         //     $('body').append('<img src=' + loadedImageUri + '>');
// //         // };

// //         // fileReader.readAsDataURL(this.files[0]);

// //         var loadedImageUri = event.target.result;

// //         console.log("hoge")
// //         console.log(loadedImageUri)

// //           // プレビューを追加するdivを取得
// //           var target_ul = $("#item-append-target");

// //           //追加するhtml-liを生成
// //           var html = `<li class="contents-item__container__uploadbox__zone-item__have-item--upload-item">
// //           <figure class="contents-item__container__uploadbox__zone-item__have-item--upload-figure">
// //           <img alt="test" src="${loadedImageUri}" class="contents-item__container__uploadbox__zone-item__have-item--upload-image">
// //           </figure>
// //           <div class="contents-item__container__uploadbox__zone-item__have-item__upload-btnbox">
// //           <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn">　</a>
// //           <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn btn-left" href="#">削除</a>
// //           </div>
// //           </li>`;

// //           // append
// //           target_ul.append(html);
// //           count += 1
// //           if (count >= 5) {
// //               // ドラッグアンドドロップのlabelを削除
// //               $("#item-drop-zone").css('display','none');
// //           }          
// //         };
// //         fr.readAsDataURL(files[i]);
// //       })();
      
// //     }
// //   }, false);
// // })
  
