

$(function(){

	$('.js-table-to-list').each(function(){
		var $table = $(this),
			$ths = $table.find('th'),
			$tds = $table.find('td'),
			$list = $('<ul>').addClass('tourix-adaptive-list'),
			$li;

		for (var i = 0, tdc = $tds.length; i< tdc; i++) {
			$li = $('<li>').addClass('tourix-adaptive-list__tr')
				.append(
					$('<span>')
						.addClass('tourix-adaptive-list__th')
						.text($ths.eq(i%$ths.length).text())
				)
				.append(
					$('<span>')
						.addClass('tourix-adaptive-list__td')
						.text($tds.eq(i).text())
				);
			$list.append($li);
		}
		$table.after($list);
	});

});