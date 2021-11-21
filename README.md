# tq-marriage
:(

qb-inventory/html/app.js/ kısmına ekle

} if (itemData.name == "evlilikyuzugu") {
  $(".item-info-title").html('<p>'+itemData.label+'</p>')
  $(".item-info-description").html('<p><strong>Toplam Ağırlık: </strong><span>' + ((itemData.weight * itemData.amount) / 1000).toFixed(1) + 'kg</span></p><p><strong>Aile: </strong><span>' + itemData.info.aile + '</span></p><p><strong>Nişan Tarihi: </strong><span>' + itemData.info.tarih + '</span></p>');
}
