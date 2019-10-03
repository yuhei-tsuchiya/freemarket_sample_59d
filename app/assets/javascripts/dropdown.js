$(function() {

  var count = 0

  function ajaxSelectbox(cat){
    $.ajax({
      type: 'GET',
      url: '/api/select_child',
      data: { cat: cat },
      dataType: 'html',
    })
    .done(function(html) {
      console.log('done')
      console.log(html)
      $('#select-category-box').append(html)
    })
    .fail(function() {
      console.log('fail')

    })
  }

  $('#select-cat1').change(function() {
    
    var cat = $('option:selected').val();
    console.log(`cat1: ${cat}`);
    
    ajaxSelectbox(cat)
    count += 1
  })

  $(document).on("change", "#select-cat2", function(){
    console.log("2つ目のcatクリック")
    var cat = $('#select-cat2 option:selected').val();
    if (cat != '') {
      console.log(`cat2: ${cat}`)
      ajaxSelectbox(cat)
      count += 1
    } else {
      if ($('#select-cat3 option:selected'))
      $('#select-cat3 option:selected').remove()
    }
  });
 


})


// $("#user-search-field").on("keyup", function(e) {
//   var input = $("#user-search-field").val();

//   $.ajax({
//     type: 'GET',
//     url: '/users',
//     data: { keyword: input },
//     dataType: 'json',
//   })

//   .done(function(users) {

//     $("#user-search-result").empty();
//     if (users.length !== 0) {
//       users.forEach(function(user){
//         if( $('.chat-group-user__btn--remove[data-user-id="' + user.id + '"]').length ) {
//           console.log("すでにグループメンバーにユーザーがいます")
//         } else {
//           appendUser(user);
//         }
//       })
//     } else {
//       appendErrMsgToHTML("一致するユーザーはありません");
//     }

//     $('.chat-group-user__btn--add').on('click', function(e){
//       var target = $(e.target);
//       var user_id = target.data('user-id')
//       var user_name = target.data('user-name')
      
//       appendMember(user_id, user_name);
//       target.parent().remove();

//     })
//   })
//   .fail(function() {
//     console.log("fail");
//     alert('ユーザー検索に失敗しました');
//   })
// })
// // 削除ボタン押した時の動作
// $('.chat-group-user__btn--remove').on('click', function(e){
//   var target = $(e.target);
//   // var user_id = target.data('user-id')
//   target.parent().remove();
// })