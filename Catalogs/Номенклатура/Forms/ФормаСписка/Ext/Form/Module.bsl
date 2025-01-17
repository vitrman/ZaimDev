﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

	ВыводДанныхСписка();
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатурой.ПриСозданииНаСервереФормаСпискаНоменклатуры(
		ЭтотОбъект,
		Элементы.ГруппаКомандыРаботаСНоменклатурой,
		Элементы.Список,,
		Новый Структура("ДобавитьКомандыСопоставления", Ложь));
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатуройБК.ЗаполнитьРеквизитыФормыДляРаботыСервиса(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	Если ИмяСобытия = РаботаСНоменклатуройКлиент.ОписаниеОповещенийПодсистемы().ЗагрузкаНоменклатуры Тогда
		Если Параметр.СозданныеОбъекты.Количество() > 0 Тогда
			Элементы.Список.ТекущаяСтрока = Параметр.СозданныеОбъекты[0].Номенклатура;
		КонецЕсли;
	ИначеЕсли ИмяСобытия = РаботаСНоменклатуройКлиент.ОписаниеОповещенийПодсистемы().СопоставлениеНоменклатуры Тогда
		Элементы.Список.Обновить();
	КонецЕсли;
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ



&НаКлиенте
Процедура ИзменитьВыделенные(Команда)
	
	ГрупповоеИзменениеОбъектовКлиент.ИзменитьВыделенные(Элементы.Список);

КонецПроцедуры

&НаКлиенте
Функция ПечатьШтрихкодовНоменклатуры(ПараметрыПечати) Экспорт
	
	СтруктураРезультат = Новый Структура;
	СтруктураРезультат.Вставить("ОбъектыПечати"				, ПараметрыПечати.ОбъектыПечати);
	СтруктураРезультат.Вставить("Идентификатор" 			, УникальныйИдентификатор);
	СтруктураРезультат.Вставить("Форма"						, ЭтаФорма);
	
	УправлениеПечатьюБККлиент.ПечатьШтрихкодовНоменклатуры(СтруктураРезультат);
	
КонецФункции

// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуРаботаСНоменклатурой(Команда)
	РаботаСНоменклатуройКлиент.ВыполнитьПодключаемуюКоманду(ЭтотОбъект, Команда);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыборРаботаСНоменклатурой(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	РаботаСНоменклатуройКлиент.ВыборВТаблицеФормы(ЭтотОбъект, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка);
КонецПроцедуры
// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦ ФОРМЫ

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	
	ВССерверПереопределяемый.УстановитьПараметрыДинамическогоСпискаНоменклатуры(Строки);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
     ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
     ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры
 
&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
     ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Элементы.Список);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
     ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаСервере
Процедура ВыводДанныхСписка()
	
	Видимость = ЭСФСервер.ВедетсяУчетПоТоварамНаВС(ТекущаяДата());
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ПризнакПеречняИзьятий",
		"Видимость",
		Видимость);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ПризнакУникальногоТовара",
		"Видимость",
		Видимость);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ПризнакУчетаНаВиртуальномСкладе",
		"Видимость",
		Видимость);
	
	Если НЕ Видимость Тогда
		
		Список.ТекстЗапроса = "ВЫБРАТЬ
		|	СправочникНоменклатура.Ссылка КАК Ссылка,
		|	СправочникНоменклатура.ПометкаУдаления КАК ПометкаУдаления,
		|	СправочникНоменклатура.Родитель КАК Родитель,
		|	СправочникНоменклатура.ЭтоГруппа КАК ЭтоГруппа,
		|	СправочникНоменклатура.Код КАК Код,
		|	СправочникНоменклатура.Наименование КАК Наименование,
		|	СправочникНоменклатура.Артикул КАК Артикул,
		|	СправочникНоменклатура.БазоваяЕдиницаИзмерения КАК БазоваяЕдиницаИзмерения,
		|	СправочникНоменклатура.ВидНДСПриИмпорте КАК ВидНДСПриИмпорте,
		|	СправочникНоменклатура.ВидНоменклатуры КАК ВидНоменклатуры,
		|	СправочникНоменклатура.Комментарий КАК Комментарий,
		|	СправочникНоменклатура.НаименованиеПолное КАК НаименованиеПолное,
		|	СправочникНоменклатура.НоменклатурнаяГруппа КАК НоменклатурнаяГруппа,
		|	СправочникНоменклатура.СтавкаНДС КАК СтавкаНДС,
		|	СправочникНоменклатура.Услуга КАК Услуга,
		|	СправочникНоменклатура.СтавкаАкциза КАК СтавкаАкциза,
		|	СправочникНоменклатура.КодКПВЭД КАК КодКПВЭД,
		|	СправочникНоменклатура.КоэффициентРасчетаОблагаемойБазыАкциза КАК КоэффициентРасчетаОблагаемойБазыАкциза,
		|	СправочникНоменклатура.ВидПодакцизногоТМЗ КАК ВидПодакцизногоТМЗ,
		|	СправочникНоменклатура.КодТНВЭД КАК КодТНВЭД,
		|	СправочникНоменклатура.ИдентификаторТовараЭСФ КАК ИдентификаторТовараЭСФ,
		|	СправочникНоменклатура.ДополнительныеРеквизиты.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Свойство КАК Свойство,
		|		Значение КАК Значение,
		|		ТекстоваяСтрока КАК ТекстоваяСтрока
		|	) КАК ДополнительныеРеквизиты,
		|	СправочникНоменклатура.Предопределенный КАК Предопределенный,
		|	СправочникНоменклатура.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных
		|ИЗ
		|	Справочник.Номенклатура КАК СправочникНоменклатура";
		
	Иначе
			
		Поля = Новый Массив;
		Поля.Добавить("ПризнакУчетаНаВиртуальномСкладе");
		Поля.Добавить("ПризнакУникальногоТовара");
		Поля.Добавить("ПризнакПеречняИзьятий");
		
		Список.УстановитьОграниченияИспользованияВГруппировке(Поля);
		Список.УстановитьОграниченияИспользованияВОтборе(Поля);
		Список.УстановитьОграниченияИспользованияВПорядке(Поля);
			
	КонецЕсли;
	
КонецПроцедуры
