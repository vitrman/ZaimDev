﻿
Функция ЭтоGTIN(GTIN) Экспорт
	Возврат МенеджерОборудованияКлиентСервер.ПроверитьКорректностьGTIN(GTIN);
КонецФункции

Функция МРЦПоВидуУпаковки(МРЦСтрокой, ВидУпаковки) Экспорт
	Возврат РазборКодаМаркировкиИСМПТКСлужебныйКлиентСервер.МРЦПоВидуУпаковки(МРЦСтрокой, ВидУпаковки);
КонецФункции

Функция ШтрихкодEANИзGTIN(GTIN) Экспорт
	Возврат ШтрихкодированиеИСМПТККлиентСервер.ШтрихкодEANИзGTIN(GTIN)
КонецФункции
