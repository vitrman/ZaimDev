﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("СтруктураДанных") Тогда
		ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Параметры.СтруктураДанных);
	КонецЕсли;
	
	Параметры.Свойство("ДатаЗапрета", ДатаЗапрета);
	
	Если МенеджерЗаписи.Страна = Справочники.КлассификаторСтранМира.ПустаяСсылка() Тогда // Лицо без гражданства
		Гражданство = 1;
	ИначеЕсли МенеджерЗаписи.Страна = Справочники.КлассификаторСтранМира.Казахстан Тогда // Гражданин РК
		Гражданство = 2;
	Иначе  																				 // Гражданин другого государства
		Гражданство = 3;
	КонецЕсли;

	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ГражданствоПриИзменении(Элемент)

	Если Гражданство = 2 Тогда	// гражданин РК	
		МенеджерЗаписи.Страна = ПредопределенноеЗначение("Справочник.КлассификаторСтранМира.Казахстан");
		МенеджерЗаписи.НомерНалоговойРегистрацииВСтранеРезидентства = "";
		МенеджерЗаписи.НеЯвляетсяНалоговымРезидентомРК = Ложь;
		МенеджерЗаписи.ИностранныйСпециалист = Ложь;
	ИначеЕсли Гражданство = 3 Тогда // гражданин иностранного государства		
		МенеджерЗаписи.Страна = ПредопределенноеЗначение("Справочник.КлассификаторСтранМира.ПустаяСсылка");
		Иначе // лицо без гражданства		
		МенеджерЗаписи.Страна = ПредопределенноеЗначение("Справочник.КлассификаторСтранМира.ПустаяСсылка");
		МенеджерЗаписи.НомерНалоговойРегистрацииВСтранеРезидентства = "";
	КонецЕсли;

	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура НеЯвляетсяНалоговымРезидентомРКПриИзменении(Элемент)
	
	ПризнакНеЯвляетсяНалоговымРезидентом = МенеджерЗаписи.НеЯвляетсяНалоговымРезидентомРК;
	
	МенеджерЗаписи.НеИмеетПравоНаПенсию                         = ПризнакНеЯвляетсяНалоговымРезидентом;
	МенеджерЗаписи.НеПодлежитСоциальномуМедицинскомуСтрахованию = ПризнакНеЯвляетсяНалоговымРезидентом;
	МенеджерЗаписи.НеПодлежитСоциальномуСтрахованию             = ПризнакНеЯвляетсяНалоговымРезидентом;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура КомандаЗаписатьИЗакрыть(Команда)
	
	Отказ = Ложь;
	Если НЕ ЗначениеЗаполнено(МенеджерЗаписи.Период) Тогда
		СообщениеОбОшибке = НСтр("ru = 'Необходимо указать период, с которого будет действовать запись сведений'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"Период", "МенеджерЗаписи", Отказ);
	ИначеЕсли МенеджерЗаписи.Период <= ДатаЗапрета Тогда
		СообщениеОбОшибке = НСтр("ru = 'Период закрыт для редактирования, укажите период позже даты '") + Формат(ДатаЗапрета, "ДФ='дд ММММ гггг'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей.Период", , Отказ);
	Иначе
		НайденныеСтроки = ВладелецФормы.НаборЗаписей.НайтиСтроки(Новый Структура("Период", МенеджерЗаписи.Период));
		Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			Если НайденнаяСтрока <> ВладелецФормы.Элементы.НаборЗаписей.ТекущиеДанные Тогда
				СообщениеОбОшибке = НСтр("ru = 'Уже есть запись с указанным периодом сведений'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"Период", "МенеджерЗаписи", Отказ);
				Прервать;
			КонецЕсли; 
		КонецЦикла;
	КонецЕсли; 

	Если НЕ Отказ Тогда
		ПараметрОповещения = Новый Структура("МенеджерЗаписи", МенеджерЗаписи);
		Оповестить("ЗавершениеРедактирования", ПараметрОповещения, ЭтаФорма);
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	
	Оповестить("ОтменаРедактирования", , ЭтаФорма);
	Закрыть();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	
	Если Форма.Гражданство = 2 Тогда		
		Элементы.Страна.Доступность = Ложь;
		Элементы.НомерНалоговойРегистрацииВСтранеРезидентства.Доступность = Ложь;
		Элементы.НеЯвляетсяНалоговымРезидентомРК.Доступность = Ложь;
		Элементы.ИностранныйСпециалист.Доступность = Ложь;
		Элементы.НадписьРасшифровкаЯвляетсяИностраннымСпециалистом.Доступность = Ложь;
	ИначеЕсли Форма.Гражданство = 3 Тогда 		
		Элементы.Страна.Доступность = Истина;                                           		
		Элементы.НомерНалоговойРегистрацииВСтранеРезидентства.Доступность = Истина;
		Элементы.НеЯвляетсяНалоговымРезидентомРК.Доступность = Истина;
		Элементы.ИностранныйСпециалист.Доступность = Истина;
		Элементы.НадписьРасшифровкаЯвляетсяИностраннымСпециалистом.Доступность = Истина;
	Иначе
		Элементы.Страна.Доступность = Ложь;                                           		
		Элементы.НомерНалоговойРегистрацииВСтранеРезидентства.Доступность = Ложь;
		Элементы.НеЯвляетсяНалоговымРезидентомРК.Доступность = Истина;
		Элементы.ИностранныйСпециалист.Доступность = Истина;
		Элементы.НадписьРасшифровкаЯвляетсяИностраннымСпециалистом.Доступность = Истина;
	КонецЕсли;

КонецПроцедуры

