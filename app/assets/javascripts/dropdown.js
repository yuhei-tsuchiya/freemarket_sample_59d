$(function() {

  // カテゴリー用変数定義
  var count = 0

  // カテゴリー用関数-カテゴリー選択表示
  function ajaxSelectbox(cat, flag, cat_id){
    $.ajax({
      type: 'GET',
      url: '/api/select_child',
      data: { cat: cat, flag: flag, cat_id: cat_id },
      dataType: 'html',
    })
    .done(function(html) {
      if (flag == 0){  // 0:option属性一覧を追加
        var select_cat = `#select-cat${cat_id}`
        $(select_cat).append(html)
      } else if (flag == 1){  // 1:divにselect・optionを追加
        $('#select-category-box').append(html)
      } else {
        return
      }
    })
    .fail(function() {
      alert('ajax通信に失敗しました')
    })
  }

  // カテゴリー用関数-サイズ・ブランド選択表示
  function ajaxSizeBrand(cat){
    $.ajax({
      type: 'GET',
      url: '/api/display_size',
      data: { cat: cat },
      dataType: 'html',
    })
    .done(function(html) {
      if (html != 0){
        $('#category-select-box').after(html)
      }
    })
    .fail(function() {
      alert('ajax通信に失敗しました')
    })
  }

  // 配達について用関数-配送の方法選択表示
  function ajaxBurdenbox(burden){
    $.ajax({
      type: 'GET',
      url: '/api/select_burden',
      data: { burden: burden },
      dataType: 'html',
    })
    .done(function(html) {
      if (html != 0){
        $('#burden-select-box').after(html)
      }
    })
    .fail(function() {
      alert('ajax通信に失敗しました')
    })
  }

  // ブランドのインクリメンタルサーチ用関数
  function ajaxSearch(target){
    $.ajax({
      type: 'GET',
      url: '/api/search_brand',
      data: {keyword: target},
      dataType: 'json'
    })
    .done(function(json) {
      $('.brand-ul').empty();
      if (json.length !== 0) {
        json.forEach(function(brand, index) { //dataは配列型に格納されているのでEach文で回す
          builtHTML(brand, index)
        });
      } else {
        $('.brand-ul').append(`<li class="brand-list">該当するブランドはありません</li>`)
      }

    })
    .fail(function() {
      alert('ajax通信に失敗しました')
    })
  }

  // ブランドのインクリメンタルサーチ用関数-HTMLをappend
  function builtHTML(brand, index){
    if (index == 1){
      $('.brand-ul').show();
    }
    html = `<li class="brand-list" data-brand=${brand.id}>${brand.name}</li>`
    $('.brand-ul').append(html)
  }
  
  
 
  // カテゴリー1用トリガー
  $(document).on("change", "#select-cat1", function(){
    if ($('#select-cat2 option').length == 0){
      var cat = $('#select-cat1 option:selected').val();
      
      count = 1
      if (cat == '---') {
        cat = 0
      }
      ajaxSelectbox(cat, 1, 2)
      return
    }
    if ($('#select-cat3')) { // カテゴリー3を消す
      $('#select-cat3').prev().remove()
      $('#select-cat3').remove()
    }
    if ($('#size-select-box').length){ // サイズがあれば削除
      $('#size-select-box').remove()
    }
    if ($('#brand-text').length){  // ブランドがあれば削除
      $('#brand-select-box').remove()
      // $('#brand-text').parent.parent.remove()
      $('.brand-ul').hide();
    }
    var cat = $('#select-cat1 option:selected').val();
    if (cat == '---' || cat == '') {  // カテゴリー1が空の時
      $('#select-cat2').prev().remove()  // カテゴリー2を消す
      $('#select-cat2').remove()
      count = 0
    } else {  // カテゴリー1が空ではない時
      $('#select-cat2 option').remove()  // カテゴリー2の中身を削除
      ajaxSelectbox(cat, 0, 2)
    }
  })

  // カテゴリー2&サイズ用トリガー
  $(document).on("change", "#select-cat2", function(){
    var cat = $('#select-cat2 option:selected').val();
    if ($('#size-select-box').length){ // サイズがあれば削除
      $('#size-select-box').remove()
    }
    if ($('#brand-text').length){  // ブランドがあれば削除
      $('#brand-select-box').remove()
    }
    if (cat != '---') {  // カテゴリー2が空でない場合
      if ($('#select-cat3').length){
        $('#select-cat3 option').remove()  // カテゴリー3の中身を削除
        ajaxSelectbox(cat, 0, 3)
      } else {
        ajaxSelectbox(cat, 1, 3)
      }
      // サイズとブランドを表示するか判別
      ajaxSizeBrand(cat)

    } else {
      if ($('#select-cat3')) {  // カテゴリー2が空の時、カテゴリー3を消す
        $('#select-cat3').prev().remove()
        $('#select-cat3').remove()
      }
    }
  });

  // 配送について用トリガー
  $(document).on("change", "#select-burden", function(){
    if ($('#burden-ways').length) {
      $('#burden-ways').remove()
    }
    var burden = $('#select-burden option:selected').val();
    if ((burden != "") && (burden != '---')){
      ajaxBurdenbox(burden)
    }
  })

  // 値段計算
  $(document).on("change", "#item_price", function(){
    if ($.isNumeric($('#item_price').val())){
      var price = $('#item_price').val()
      price = Number(price)
      var price_fee = Math.round(price * 0.1)
      $('#price-fee').text(`¥${price_fee}`)
      $('#price-benefit').text(`¥${price - price_fee}`)
    } else {
      alert("数値を入力してください")
    }
  })

  // ブランドのインクリメンタルサーチ
  $(document).on("keyup", "#brand-text", function(){
    if ($("#brand-text").val() == ''){
      $('.brand-ul').empty();
    } else {
      var target = $(this).val();
      ajaxSearch(target);
    }
  })

  $(document).on("click", ".brand-list", function(e){
    if ($('#brand-decided').length){
      $('#brand-decided').remove()
    }
    var target = $(e.target);
    $("#brand-text").val(target.text());
    html = `<input type="hidden" id="brand-decided", name="item[brand_id]" value="${target.data('brand')}"></input>`
    $("#brand-text").append(html)
    $('.brand-ul').empty();
  })
})
