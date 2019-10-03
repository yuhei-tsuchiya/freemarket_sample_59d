
$(function() {

  // var list = [];
  var list = new DataTransfer();
  // filelist.push(file)

  function readURL(input, list) {
    if (input.files && input.files[0]) {
      $.each(input.files, function(index, file) {
        list.items .add(file);
        var reader = new FileReader();
        var target_ul = $("#item-append-target");
        reader.onload = function (e) {
          var loadedImageUri = e.target.result;
          // $('#img_prev').attr('src', e.target.result);
          var html = `<li class="contents-item__container__uploadbox__zone-item__have-item--upload-item">
            <figure class="contents-item__container__uploadbox__zone-item__have-item--upload-figure">
            <img alt="test" src="${loadedImageUri}" class="contents-item__container__uploadbox__zone-item__have-item--upload-image">
            </figure>
            <div class="contents-item__container__uploadbox__zone-item__have-item__upload-btnbox">
            <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn">　</a>
            <a class="contents-item__container__uploadbox__zone-item__have-item--upload-btn btn-left" href="#">削除</a>
            </div>
            </li>`;
          target_ul.append(html);
        }
        reader.readAsDataURL(input.files[index]);
      })
    }
  }

  $("#item-drop-zone").change(function(){
    console.log("hoge")

    // プレビュー表示
    readURL(this, list);

    // 既存の選択中ファイルをフォームに入れる(リセットされるため)
    // list
    console.log(list)
    if (list.files && list.files[0]) {

      let myFileList = list.files;

      console.log("myFileList")
      console.log(myFileList)

      document.querySelector('input[type=file]').files = myFileList;

      console.log("input[type=file]")
      console.log(document.querySelector('input[type=file]').files)
      
    }
   
  });
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
  
