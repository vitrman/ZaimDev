﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

// Процедура управляет показом в форме периода построения отчета.
//
&НаКлиентеНаСервереБезКонтекста
Процедура ПоказатьПериод(Форма)

	Если  (Форма.мДатаКонцаПериодаОтчета < Форма.мДатаНачалаПериодаОтчета) Тогда
		Сообщить("Неверно задан период", СтатусСообщения.Важное);
		Возврат;
	КонецЕсли;

	СтрПериодОтчета = ПредставлениеПериода(НачалоДня(Форма.мДатаНачалаПериодаОтчета), КонецДня(Форма.мДатаКонцаПериодаОтчета), "ФП = Истина" );
		
	Форма.НадписьПериодСоставленияОтчета = СтрПериодОтчета;

	КоличествоФорм = РегламентированнаяОтчетностьКлиентСервер.КоличествоФормСоответствующихВыбранномуПериоду(Форма);
	Если КоличествоФорм >= 1 Тогда

		Форма.Элементы.ОткрытьФормуОтчета.Доступность = Истина;

	Иначе		

		Форма.ОписаниеНормативДок = "";
		Форма.Элементы.ОткрытьФормуОтчета.Доступность = Ложь;
		
	КонецЕсли;

	РегламентированнаяОтчетностьКлиентСервер.ВыборФормыРегламентированногоОтчетаПоУмолчанию(Форма);

КонецПроцедуры

// Процедура устанавливает границы периода построения отчета.
//
// Параметры:
//  Шаг          - число, количество стандартных периодов, на которое необходимо
//                 сдвигать период построения отчета;
//
&НаКлиенте
Процедура ИзменитьПериод(Шаг)

	Если ПолеВыбораПериодичность = ПеречислениеПериодичностьКвартал Тогда  // ежеквартально
		мДатаКонцаПериодаОтчета  = КонецКвартала(ДобавитьМесяц(мДатаКонцаПериодаОтчета, Шаг*3));
		мДатаНачалаПериодаОтчета = НачалоКвартала(мДатаКонцаПериодаОтчета);
	Иначе
		мДатаКонцаПериодаОтчета  = КонецМесяца(ДобавитьМесяц(мДатаКонцаПериодаОтчета, Шаг)); 
		мДатаНачалаПериодаОтчета = НачалоМесяца(мДатаКонцаПериодаОтчета);
	КонецЕсли;

	ПоказатьПериод(ЭтаФорма);

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Налогоплательщик         = Параметры.Налогоплательщик;
	мДатаНачалаПериодаОтчета = Параметры.мДатаНачалаПериодаОтчета;
	мДатаКонцаПериодаОтчета  = Параметры.мДатаКонцаПериодаОтчета;
	мПериодичность           = Параметры.мПериодичность;
	мСкопированаФорма        = Параметры.мСкопированаФорма;
	мСохраненныйДок          = Параметры.мСохраненныйДок;
	
	Если Параметры.Свойство("НалоговыйКомитет") Тогда	
		НалоговыйКомитет = Параметры.НалоговыйКомитет;
	КонецЕсли;	
	
	Если ЗначениеЗаполнено(Параметры.мВыбраннаяФорма) Тогда
		мПараметрыПрежнейФормы = Новый Структура("мВыбраннаяФорма, мСохраненныйДок, Налогоплательщик, мДатаНачалаПериодаОтчета, мДатаКонцаПериодаОтчета, НалоговыйКомитет",
												Параметры.мВыбраннаяФорма, Параметры.мСохраненныйДок, Параметры.Налогоплательщик, Параметры.мДатаНачалаПериодаОтчета, Параметры.мДатаКонцаПериодаОтчета, НалоговыйКомитет);

	КонецЕсли;
			
	ИсточникОтчета = СтрЗаменить(СтрЗаменить(Строка(ЭтаФорма.ИмяФормы), "Отчет.", ""), ".Форма.ОсновнаяФорма", "");
	
	ТаблицаФормОтчета = РеквизитФормыВЗначение("ОтчетОбъект").ТаблицаФормОтчета();
	
	ЗначениеВДанныеФормы(ТаблицаФормОтчета, мТаблицаФормОтчета);
	
	Элементы.ПолеВыбораПериодичность.СписокВыбора.Добавить(Перечисления.Периодичность.Месяц);
	Элементы.ПолеВыбораПериодичность.СписокВыбора.Добавить(Перечисления.Периодичность.Квартал);
    		
	УчетПоВсемОрганизациям 	= РегламентированнаяОтчетностьПереопределяемый.ПолучитьПризнакУчетаПоВсемОрганизациям();
	ПеречислениеРазделыНалоговогоУчета = Перечисления.РазделыНалоговогоУчета.НДС;	

	ОрганизацияПоУмолчанию = РегламентированнаяОтчетностьПереопределяемый.ПолучитьОрганизациюПоУмолчанию();
	
	ПеречислениеПериодичностьМесяц   = Перечисления.Периодичность.Месяц;
	ПеречислениеПериодичностьКвартал = Перечисления.Периодичность.Квартал;
		
	// Устанавливаем границы периода построения отчета как квартал
	// предшествующий текущему, нарастающим итогом с начала года.
	Если НЕ ЗначениеЗаполнено(мДатаНачалаПериодаОтчета) И НЕ ЗначениеЗаполнено(мДатаКонцаПериодаОтчета) Тогда
		
		мДатаНачалаПериодаОтчета = НачалоКвартала(ТекущаяДатаСеанса());
		мДатаКонцаПериодаОтчета  = КонецКвартала(ТекущаяДатаСеанса());
		
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(мПериодичность) ИЛИ НЕ (мПериодичность = ПеречислениеПериодичностьМесяц ИЛИ мПериодичность = ПеречислениеПериодичностьКвартал) Тогда
		мПериодичность = ПеречислениеПериодичностьКвартал;
	КонецЕсли;

	ПолеВыбораПериодичность = мПериодичность;
	
	ПоказатьПериод(ЭтаФорма);
		
	Если НЕ ЗначениеЗаполнено(Налогоплательщик) 
	   И ЗначениеЗаполнено(ОрганизацияПоУмолчанию) Тогда
		Налогоплательщик = ОрганизацияПоУмолчанию;
	КонецЕсли;	
	
	// Если НДС за организацию, указанную в переменной Налогоплательщик, оплачивает другая организация,
	// то изменить значение переменной Налогоплательщик на организацию, которая является плательщиком НДС.	
	Налогоплательщик = ПроцедурыНалоговогоУчетаВызовСервераПовтИсп.ПолучитьНалогоплательщикаСтруктурнойЕдиницы(
		Налогоплательщик,
		Налогоплательщик,
		Перечисления.РазделыНалоговогоУчета.НДС
	);
	
	ЗаполнитьСписокВыбораПоляНалогоплательщик();	
	ЗаполнитьСписокВыбораПоляНалоговыйКомитет(Налогоплательщик);
	УстановитьНалоговыйКомитетДляНалогоплательщика(Элементы.НалоговыйКомитет.СписокВыбора, Налогоплательщик);
		
	мПоддержкаРаботыСоСтруктурнымиПодразделениями = ПолучитьФункциональнуюОпцию("ПоддержкаРаботыСоСтруктурнымиПодразделениями");
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

	// здесь отключаем стандартную обработку ПередЗакрытием формы
	// для подавления выдачи запроса на сохранение формы.
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура ПолеВыбораПериодичностьПриИзменении(Элемент)
	
	Если ПолеВыбораПериодичность = ПеречислениеПериодичностьКвартал Тогда  // ежеквартально
		мДатаКонцаПериодаОтчета  = КонецКвартала(мДатаКонцаПериодаОтчета);
		мДатаНачалаПериодаОтчета = НачалоКвартала(мДатаКонцаПериодаОтчета);
	Иначе
		мДатаКонцаПериодаОтчета  = КонецМесяца(мДатаКонцаПериодаОтчета);
		мДатаНачалаПериодаОтчета = НачалоМесяца(мДатаКонцаПериодаОтчета);
	КонецЕсли;

	мПериодичность = ПолеВыбораПериодичность;
	
	ПоказатьПериод(ЭтаФорма);
		
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПредыдущийПериод(Команда)
	
	ИзменитьПериод(-1);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСледующийПериод(Команда)
	
	ИзменитьПериод(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуОтчета(Команда)
	
	Если НЕ ЗначениеЗаполнено(Налогоплательщик) Тогда						
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(РегламентированнаяОтчетностьКлиент.ОсновнаяФормаОрганизацияНеЗаполненаВывестиТекст());				
		Возврат;		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(мВыбраннаяФорма) Тогда				
		ТекстСообщения = НСтр("ru='Форма отчета для указанного периода не определена.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);				
		Возврат;		
	КонецЕсли;

	Если мСкопированаФорма <> Неопределено Тогда
		// Документ был скопиран. 
		// Проверяем соответствие форм.
		Если мВыбраннаяФорма <> мСкопированаФорма Тогда
			
			ПоказатьПредупреждение(,(НСтр("ru='Форма отчета изменилась, копирование невозможно!'")));
			Возврат;
						
		КонецЕсли;
	КонецЕсли;
	
	// Основная форма была открыта из формы периода.
	Если мПараметрыПрежнейФормы <> Неопределено Тогда
		
		ТекстИзменений = НСтр("ru = 'Изменены параметры формирования отчета:'");
		ЕстьИзменения = Ложь;
		НеобходимоСохранитьФорму = Ложь;
		НеобходимоОчиститьФорму = Ложь;
		
		Если мПараметрыПрежнейФормы.Налогоплательщик <> Налогоплательщик Тогда
			ТекстИзменений = ТекстИзменений + НСТР("ru = ' налогоплательщик'");
			ЕстьИзменения = Истина;
			НеобходимоОчиститьФорму = Истина;
		КонецЕсли;	
		
		Если мПараметрыПрежнейФормы.НалоговыйКомитет <> НалоговыйКомитет Тогда
			ТекстИзменений = ТекстИзменений + НСТР("ru = ' налоговый комитет'");
			ЕстьИзменения = Истина;
			НеобходимоОчиститьФорму = Истина;
		КонецЕсли;
		
		Если мПараметрыПрежнейФормы.мДатаНачалаПериодаОтчета <> мДатаНачалаПериодаОтчета ИЛИ мПараметрыПрежнейФормы.мДатаКонцаПериодаОтчета <> мДатаКонцаПериодаОтчета Тогда
			ТекстИзменений = ТекстИзменений + ?(ЕстьИзменения, НСТР("ru=' и '"), "") + НСТР("ru = 'отчетный период'");
			ЕстьИзменения = Истина;
			НеобходимоОчиститьФорму = Истина;
		КонецЕсли;	
						
		Если мПараметрыПрежнейФормы.мВыбраннаяФорма <> мВыбраннаяФорма Тогда
			ЕстьИзменения = Истина;
			НеобходимоСохранитьФорму = Истина;
		КонецЕсли; 
		
		Если ЕстьИзменения И НеобходимоСохранитьФорму Тогда			
			// форма открыта из формы отчета. При изменении формы периода требуется открыть новую форму
			ТекстВопроса = ТекстИзменений + НСТР("ru = '. Будет закрыта форма текущего отчета и открыта новая форма, соответствующая данному периоду. Продолжить?'");
			
			ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВопросОНеобходимостиЗакрытияПредыдущейФормы",
			ЭтотОбъект);
			ПоказатьВопрос(ОбработчикОповещенияОЗакрытии, ТекстВопроса, РежимДиалогаВопрос.ДаНет);		
			Возврат; // дальнейшие действия будут выполнены в обработке оповещения
			
		КонецЕсли;	
		
		Если ЕстьИзменения И НеобходимоОчиститьФорму Тогда
			// форма открыта из формы отчета. При изменении формы периода требуется открыть новую форму
			ТекстВопроса = ТекстИзменений + НСТР("ru = '. Данные в форме будут очищены! Продолжить?'");
			
			ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВопросОНеобходимостиОчисткиПредыдущейФормы", ЭтотОбъект);
			ПоказатьВопрос(ОбработчикОповещенияОЗакрытии, ТекстВопроса, РежимДиалогаВопрос.ДаНет);		
			Возврат; // дальнейшие действия будут выполнены в обработке оповещения
			
		КонецЕсли;	
	КонецЕсли;	
		
	ОткрытьВыбраннуюФорму();
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросОНеобходимостиЗакрытияПредыдущейФормы(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ВладелецФормы.СохранитьДанные(); // экспортная процедура формы
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСТР("ru = 'Не удалось сохранить отчет.'"));
	КонецПопытки;

	Если ВладелецФормы <> Неопределено Тогда
		ВладелецФормы.Закрыть();
	КонецЕсли;
	
	мСохраненныйДок = Неопределено;

	ОткрытьВыбраннуюФорму(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросОНеобходимостиОчисткиПредыдущейФормы(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ОсновнаяФорма = ВладелецФормы.СписокФормДерева.ПолучитьЭлементы()[0];
		КодОсновнойФормыВладельца 			   = ОсновнаяФорма.КодФормы;
		МногострочностьОсновнойФормыВладельца  = ОсновнаяФорма.Многострочность;	
		
		ВладелецФормы.ОчиститьРеглОтчетЗавершениеНаСервере(КодОсновнойФормыВладельца, МногострочностьОсновнойФормыВладельца, Истина);	

		//ВладелецФормы.Очистить(КодОсновнойФормыВладельца, Истина);
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не удалось очистить отчет.'"));
	КонецПопытки;
	
	ОткрытьВыбраннуюФорму(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВыбраннуюФорму(ОбновитьПараметрыОткрытойФормы = Ложь)

	Если мПоддержкаРаботыСоСтруктурнымиПодразделениями Тогда		
		// для формы 300.00 нужны все структурные единицы налогоплательщика с учетом налогового комитета
		мСписокСтруктурныхЕдиниц = ПроцедурыНалоговогоУчетаВызовСервераПовтИсп.СформироватьСписокСтруктурныхЕдиниц(ПеречислениеРазделыНалоговогоУчета, НалоговыйКомитет, Налогоплательщик);
	Иначе		
		// если в базе работа со структурными подразделениями не ведется, то налогоплательщик и структурная единица совпадают
		мСписокСтруктурныхЕдиниц.Очистить();
		мСписокСтруктурныхЕдиниц.Добавить(Налогоплательщик);
	КонецЕсли;
		
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("мДатаНачалаПериодаОтчета", мДатаНачалаПериодаОтчета);
	ПараметрыФормы.Вставить("мСохраненныйДок",          мСохраненныйДок);
	ПараметрыФормы.Вставить("мСкопированаФорма",        мСкопированаФорма);
	ПараметрыФормы.Вставить("мДатаКонцаПериодаОтчета",  мДатаКонцаПериодаОтчета);
	ПараметрыФормы.Вставить("мПериодичность",           мПериодичность);
	ПараметрыФормы.Вставить("Налогоплательщик",         Налогоплательщик);	
	ПараметрыФормы.Вставить("НалоговыйКомитет",         НалоговыйКомитет);
	ПараметрыФормы.Вставить("мВыбраннаяФорма",          мВыбраннаяФорма);
	ПараметрыФормы.Вставить("мСписокСтруктурныхЕдиниц", мСписокСтруктурныхЕдиниц);	
	ПараметрыФормы.Вставить("мПериодичность",			мПериодичность);		
	
	Если ОбновитьПараметрыОткрытойФормы И ВладелецФормы <> Неопределено Тогда
		// при повторном открытии не выполняется создание формы на сервере
		// необходимо самостоятельно обновить параметры формы и зависимые данные
		ВладелецФормы.ОбновитьПараметрыФормыНаКлиенте(ПараметрыФормы);
	КонецЕсли;	
	
	Попытка
		Если ВладелецФормы  = Неопределено Тогда
			ОткрытьФорму(СтрЗаменить(ЭтаФорма.ИмяФормы, "ОсновнаяФорма", "") + мВыбраннаяФорма, ПараметрыФормы);
		Иначе
			ОткрытьФорму(СтрЗаменить(ЭтаФорма.ИмяФормы, "ОсновнаяФорма", "") + мВыбраннаяФорма, ПараметрыФормы,,ВладелецФормы.КлючУникальности);
		КонецЕсли;	
		Закрыть(); // закрываем основную форму
	Исключение
		ТекстСообщения = НСтр("ru='Форма отчета для указанного периода не определена.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);		
	КонецПопытки;	
		  	
КонецПроцедуры

&НаКлиенте
Процедура НалогоплательщикПриИзменении(Элемент)
	НалогоплательщикПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура НалогоплательщикПриИзмененииНаСервере()
	
	ЗаполнитьСписокВыбораПоляНалоговыйКомитет(Налогоплательщик);
	УстановитьНалоговыйКомитетДляНалогоплательщика(Элементы.НалоговыйКомитет.СписокВыбора, Налогоплательщик);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура ЗаполнитьСписокВыбораПоляНалогоплательщик()
	
	Элементы.Налогоплательщик.СписокВыбора.Очистить();
	
	НалогоплательщикСписокВыбора = ПроцедурыНалоговогоУчета.СформироватьСписокНалогоплательщиков(Перечисления.РазделыНалоговогоУчета.НДС);	
	
	Для Каждого СтрокаНалогоплательщикСписокВыбора Из НалогоплательщикСписокВыбора Цикл
		
		Элементы.Налогоплательщик.СписокВыбора.Добавить(
			СтрокаНалогоплательщикСписокВыбора.Значение, 
			СтрокаНалогоплательщикСписокВыбора.Представление);	
			
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораПоляНалоговыйКомитет(Знач Налогоплательщик)
	
	Элементы.НалоговыйКомитет.СписокВыбора.Очистить();
	
	НалоговыйКомитетСписокВыбора = ПроцедурыНалоговогоУчетаВызовСервераПовтИсп.СформироватьСписокНалоговыхКомитетов(
		Налогоплательщик, Перечисления.РазделыНалоговогоУчета.НДС);	
	
	Для Каждого СтрокаНалоговыйКомитетСписокВыбора Из НалоговыйКомитетСписокВыбора Цикл
		
		Элементы.НалоговыйКомитет.СписокВыбора.Добавить(
			СтрокаНалоговыйКомитетСписокВыбора.Значение, 
			СтрокаНалоговыйКомитетСписокВыбора.Представление);	
			
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНалоговыйКомитетДляНалогоплательщика(Знач НалоговыйКомитетСписокВыбора, Знач Налогоплательщик)
	
	НалогоплательщикНалоговыйКомитет = Налогоплательщик.НалоговыйКомитет;
	
	Если НалоговыйКомитетСписокВыбора.НайтиПоЗначению(НалоговыйКомитет) = Неопределено
		ИЛИ НЕ ЗначениеЗаполнено(НалоговыйКомитет) Тогда				
		
		Если ЗначениеЗаполнено(Налогоплательщик.НалоговыйКомитет) 
			И НалоговыйКомитетСписокВыбора.НайтиПоЗначению(НалогоплательщикНалоговыйКомитет) <> Неопределено Тогда
			
			НалоговыйКомитет = НалогоплательщикНалоговыйКомитет;
			
		ИначеЕсли НалоговыйКомитетСписокВыбора.Количество() = 1 Тогда
			
			НалоговыйКомитет = НалоговыйКомитетСписокВыбора[0].Значение;
			
		Иначе
			
			НалоговыйКомитет = Справочники.Контрагенты.ПустаяСсылка();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры