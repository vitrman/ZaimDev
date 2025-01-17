﻿
#Область ПрограммныйИнтерфейс

Функция ФоновоеЗаданиеЗапущено(Знач ИмяПроцедуры) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ФоновоеЗаданиеЗапущено(ИмяПроцедуры);

КонецФункции

Функция ПараметрыВыполненияВФоне(Знач ИдентификаторФормы = Неопределено) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПараметрыВыполненияВФоне(ИдентификаторФормы);
	
КонецФункции

Функция ВыполнитьВФоне(Знач ИмяПроцедуры, Знач ПараметрыПроцедуры, Знач ПараметрыВыполнения) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ВыполнитьВФоне(ИмяПроцедуры, ПараметрыПроцедуры, ПараметрыВыполнения);
	
КонецФункции

Процедура ПриСозданииНаСервереЭТД(Форма) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереЭТД(Форма);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереФормыСпискаЭТД(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереФормыСпискаЭТД(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереФормыСпискаРегистраСведений(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереФормыСпискаРегистраСведений(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереРабочееМестоЭТД(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереРабочееМестоЭТД(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереСопоставлениеДолжностей(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереСопоставлениеДолжностей(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереСопоставлениеДолжностейЭТД(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереСопоставлениеДолжностейЭТД(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереСопоставлениеПричинРасторженияЭТД(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереСопоставлениеПричинРасторженияЭТД(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриСозданииНаСервереСопоставлениеПрофилейНавыковЭТД(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ЭТДСерверПереопределяемый.ПриСозданииНаСервереСопоставлениеПрофилейНавыковЭТД(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Функция ПолучитьДанныеДляАвтозаполненияЭТД(Организация, Период) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьДанныеДляАвтозаполненияЭТД(Организация, Период);
	
КонецФункции

Функция ПолучитьДолжностьОрганизации(ДолжностьПоШтатномуРасписанию) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьДолжностьОрганизации(ДолжностьПоШтатномуРасписанию)
	
КонецФункции

// Возвращает код должности республиканского справочника должностей и дату начала действия этого кода
//
// Параметры:
//  Должность	 - СправочникСсылка.ДолжностиОрганизаций - Для какой должности получить код должности
//  Организация	 - СправочникСсылка.Организации			 - Организация
// 
// Возвращаемое значение:
//  Структура - Код должности и дата начала его действия. 
//				В случае отсутствия сопоставления возвращает структуру с пустыми значениями
//
Функция ПолучитьИнформациюОКодеДолжности(Период, Должность, ДолжностьПоШтатномуРасписанию, Организация) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("КодДолжности", "");
	Результат.Вставить("НаименованиеДолжности", "");
	
	ИспользоватьШтатноеРасписание = ИспользоватьШтатноеРасписание();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ЕСТЬNULL(СопоставлениеДолжностейЭТД.КодДолжностиЭТД, СопоставлениеДолжностейЭТДАктуальное.КодДолжностиЭТД) КАК КодДолжности,
		|	ЕСТЬNULL(СопоставлениеДолжностейЭТД.НаименованиеЭТД, СопоставлениеДолжностейЭТДАктуальное.НаименованиеЭТД) КАК НаименованиеДолжности
		|ИЗ
		|	РегистрСведений.СопоставлениеДолжностейЭТД.СрезПоследних(
		|			&ТекущаяДата,
		|			Организация = &Организация
		|				"+?(ИспользоватьШтатноеРасписание,"И ДолжностьПоШтатномуРасписанию = &ДолжностьПоШтатномуРасписанию","")+"
		|				"+?(ИспользоватьШтатноеРасписание,"","И ДолжностьОрганизации = &Должность")+") КАК СопоставлениеДолжностейЭТДАктуальное
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СопоставлениеДолжностейЭТД.СрезПоследних(
		|			&Период,
		|			Организация = &Организация
		|				"+?(ИспользоватьШтатноеРасписание,"И ДолжностьПоШтатномуРасписанию = &ДолжностьПоШтатномуРасписанию","")+"
		|				"+?(ИспользоватьШтатноеРасписание,"","И ДолжностьОрганизации = &Должность")+") КАК СопоставлениеДолжностейЭТД
		|		ПО СопоставлениеДолжностейЭТДАктуальное.ДолжностьОрганизации = СопоставлениеДолжностейЭТД.ДолжностьОрганизации
		|			И СопоставлениеДолжностейЭТДАктуальное.ДолжностьПоШтатномуРасписанию = СопоставлениеДолжностейЭТД.ДолжностьПоШтатномуРасписанию";
	
	Запрос.УстановитьПараметр("Период", ?(ЗначениеЗаполнено(Период), Период, ТекущаяДатаСеанса()));
	Запрос.УстановитьПараметр("ТекущаяДата", ТекущаяДатаСеанса());
	Запрос.УстановитьПараметр("Должность", Должность);
	Запрос.УстановитьПараметр("ДолжностьПоШтатномуРасписанию", ДолжностьПоШтатномуРасписанию);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьПрофильНавыков(Период, ДолжностьПоШтатномуРасписанию, Сотрудник, Организация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	СопоставлениеПрофилейНавыковЭТДСрезПоследних.ПрофильНавыков КАК ПрофильНавыков
		|ИЗ
		|	РегистрСведений.СопоставлениеПрофилейНавыковЭТД.СрезПоследних(
		|			&Период,
		|			Организация = &Организация
		|				И (ВладелецПрофиля = &ДолжностьПоШтатномуРасписанию
		|					ИЛИ ВладелецПрофиля = &Сотрудник)) КАК СопоставлениеПрофилейНавыковЭТДСрезПоследних";
	
	Запрос.УстановитьПараметр("Период", ?(ЗначениеЗаполнено(Период), Период, ТекущаяДатаСеанса()));
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	Запрос.УстановитьПараметр("ДолжностьПоШтатномуРасписанию", ДолжностьПоШтатномуРасписанию);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.ПрофильНавыков;
	КонецЕсли;
	
	Возврат Справочники.ПрофилиНавыковЭТД.ПустаяСсылка();
	
КонецФункции

Функция ПолучитьДанныеПрофилейПоНастройкам(Период, Сотрудник, Должность, Организация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 	
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СопоставлениеПрофилейНавыковЭТДСрезПоследних.ПрофильНавыков КАК ПрофильНавыков,
	|	1 КАК Приоритет
	|ПОМЕСТИТЬ ВТ_ПрофилиПоПриоритетам
	|ИЗ
	|	РегистрСведений.СопоставлениеПрофилейНавыковЭТД.СрезПоследних(
	|			&Период,
	|			Организация = &Организация
	|				И ВладелецПрофиля = &Сотрудник) КАК СопоставлениеПрофилейНавыковЭТДСрезПоследних
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	СопоставлениеПрофилейНавыковЭТДСрезПоследних.ПрофильНавыков,
	|	2
	|ИЗ
	|	РегистрСведений.СопоставлениеПрофилейНавыковЭТД.СрезПоследних(
	|			&Период,
	|			Организация = &Организация
	|				И ВладелецПрофиля = &Должность) КАК СопоставлениеПрофилейНавыковЭТДСрезПоследних
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ПрофилиПоПриоритетам.Приоритет КАК Приоритет
	|ПОМЕСТИТЬ ВТ_МаксимумыПриоритетов
	|ИЗ
	|	ВТ_ПрофилиПоПриоритетам КАК ВТ_ПрофилиПоПриоритетам
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПрофилиНавыковЭТДОбщиеНавыки.КодНавыка КАК КодНавыка,
	|	ПрофилиНавыковЭТДОбщиеНавыки.Наименование КАК Наименование
	|ИЗ
	|	ВТ_ПрофилиПоПриоритетам КАК ВТ_ПрофилиПоПриоритетам
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_МаксимумыПриоритетов КАК ВТ_МаксимумыПриоритетов
	|		ПО ВТ_ПрофилиПоПриоритетам.Приоритет = ВТ_МаксимумыПриоритетов.Приоритет
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиНавыковЭТД.ОбщиеНавыки КАК ПрофилиНавыковЭТДОбщиеНавыки
	|		ПО ВТ_ПрофилиПоПриоритетам.ПрофильНавыков = ПрофилиНавыковЭТДОбщиеНавыки.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПрофилиНавыковЭТДОбщиеНавыки.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПрофилиНавыковЭТДПрофессиональныеНавыки.КодНавыка КАК КодНавыка,
	|	ПрофилиНавыковЭТДПрофессиональныеНавыки.Наименование КАК Наименование
	|ИЗ
	|	ВТ_ПрофилиПоПриоритетам КАК ВТ_ПрофилиПоПриоритетам
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_МаксимумыПриоритетов КАК ВТ_МаксимумыПриоритетов
	|		ПО ВТ_ПрофилиПоПриоритетам.Приоритет = ВТ_МаксимумыПриоритетов.Приоритет
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ПрофилиНавыковЭТД.ПрофессиональныеНавыки КАК ПрофилиНавыковЭТДПрофессиональныеНавыки
	|		ПО ВТ_ПрофилиПоПриоритетам.ПрофильНавыков = ПрофилиНавыковЭТДПрофессиональныеНавыки.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПрофилиНавыковЭТДПрофессиональныеНавыки.НомерСтроки";
	
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	Запрос.УстановитьПараметр("Должность", Должность);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	ВыгрузкаНавыков = Запрос.ВыполнитьПакет();
	
	НавыкиПоВидам = Новый Структура();
	
	НавыкиПоВидам.Вставить("ОбщиеНавыки", ВыгрузкаНавыков[2].Выгрузить());
	НавыкиПоВидам.Вставить("ПрофессиональныеНавыки", ВыгрузкаНавыков[3].Выгрузить());
		
	Возврат НавыкиПоВидам;
	
КонецФункции

// Возвращает код причины расторжения договора республиканского справочника и дату начала действия этого кода
//
// Параметры:
//	ОснованиеУвольнения - СправочникСсылка.ОснованиеУвольненияИзОрганизации - Для какого основания увольнения получить код причины
//	Дата                - Дата - На какую дату получить код причины
//
// Возвращаемое значение:
//	Структура           - Код причины расторжения и дата начала его действия. В случае отсутствия сопоставления возвращает структуру с пустыми значениями
//
Функция ПолучитьИнформациюОПричинеРасторжения(Период, Организация, ОснованиеУвольнения) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("КодПричиныРасторженияЭТД", "");
	Результат.Вставить("Дата", '00010101');
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	1 КАК Приоритет,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.КодПричиныРасторженияЭТД КАК КодПричиныРасторженияЭТД,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.Период КАК Дата,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.ОснованиеУвольнения КАК ОснованиеУвольнения
		|ПОМЕСТИТЬ ВТПричиныРасторженияЭТД
		|ИЗ
		|	РегистрСведений.СопоставлениеПричинРасторженияЭТД.СрезПоследних(
		|			&Период,
		|			Организация = &Организация
		|				И ОснованиеУвольнения = &ОснованиеУвольнения) КАК СопоставлениеПричинРасторженияЭТДСрезПоследних
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	2,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.КодПричиныРасторженияЭТД,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.Период,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.ОснованиеУвольнения
		|ИЗ
		|	РегистрСведений.СопоставлениеПричинРасторженияЭТД.СрезПоследних(
		|			&Период,
		|			Организация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
		|				И ОснованиеУвольнения = &ОснованиеУвольнения) КАК СопоставлениеПричинРасторженияЭТДСрезПоследних
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МИНИМУМ(ВТПричиныРасторженияЭТД.Приоритет) КАК Приоритет,
		|	ВТПричиныРасторженияЭТД.ОснованиеУвольнения КАК ОснованиеУвольнения
		|ПОМЕСТИТЬ ВТПриоритетыПричинРасторжения
		|ИЗ
		|	ВТПричиныРасторженияЭТД КАК ВТПричиныРасторженияЭТД
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТПричиныРасторженияЭТД.ОснованиеУвольнения
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТПричиныРасторженияЭТД.КодПричиныРасторженияЭТД КАК КодПричиныРасторженияЭТД,
		|	ВТПричиныРасторженияЭТД.Дата КАК Дата
		|ИЗ
		|	ВТПриоритетыПричинРасторжения КАК ВТПриоритетыПричинРасторжения
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТПричиныРасторженияЭТД КАК ВТПричиныРасторженияЭТД
		|		ПО ВТПриоритетыПричинРасторжения.Приоритет = ВТПричиныРасторженияЭТД.Приоритет
		|			И ВТПриоритетыПричинРасторжения.ОснованиеУвольнения = ВТПричиныРасторженияЭТД.ОснованиеУвольнения";
	
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ОснованиеУвольнения", ОснованиеУвольнения);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьИнформациюОбОснованииРасторжения(Период, Организация, КодПричиныРасторженияЭТД) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("ОснованиеУвольнения", Неопределено);
	Результат.Вставить("Дата", '00010101');
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	1 КАК Приоритет,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.КодПричиныРасторженияЭТД КАК КодПричиныРасторженияЭТД,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.Период КАК Дата,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.ОснованиеУвольнения КАК ОснованиеУвольнения
		|ПОМЕСТИТЬ ВТПричиныРасторженияЭТД
		|ИЗ
		|	РегистрСведений.СопоставлениеПричинРасторженияЭТД.СрезПоследних(
		|			&Период,
		|			Организация = &Организация
		|				И КодПричиныРасторженияЭТД = &КодПричиныРасторженияЭТД) КАК СопоставлениеПричинРасторженияЭТДСрезПоследних
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	2,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.КодПричиныРасторженияЭТД,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.Период,
		|	СопоставлениеПричинРасторженияЭТДСрезПоследних.ОснованиеУвольнения
		|ИЗ
		|	РегистрСведений.СопоставлениеПричинРасторженияЭТД.СрезПоследних(
		|			&Период,
		|			Организация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
		|				И КодПричиныРасторженияЭТД = &КодПричиныРасторженияЭТД) КАК СопоставлениеПричинРасторженияЭТДСрезПоследних
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МИНИМУМ(ВТПричиныРасторженияЭТД.Приоритет) КАК Приоритет,
		|	ВТПричиныРасторженияЭТД.КодПричиныРасторженияЭТД КАК КодПричиныРасторженияЭТД
		|ПОМЕСТИТЬ ВТПриоритетыПричинРасторжения
		|ИЗ
		|	ВТПричиныРасторженияЭТД КАК ВТПричиныРасторженияЭТД
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТПричиныРасторженияЭТД.КодПричиныРасторженияЭТД
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТПричиныРасторженияЭТД.ОснованиеУвольнения КАК ОснованиеУвольнения,
		|	ВТПричиныРасторженияЭТД.Дата КАК Дата
		|ИЗ
		|	ВТПриоритетыПричинРасторжения КАК ВТПриоритетыПричинРасторжения
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТПричиныРасторженияЭТД КАК ВТПричиныРасторженияЭТД
		|		ПО ВТПриоритетыПричинРасторжения.Приоритет = ВТПричиныРасторженияЭТД.Приоритет
		|			И ВТПриоритетыПричинРасторжения.КодПричиныРасторженияЭТД = ВТПричиныРасторженияЭТД.КодПричиныРасторженияЭТД";
	
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("КодПричиныРасторженияЭТД", КодПричиныРасторженияЭТД);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Возвращает организацию по умолчанию
// 
// Возвращаемое значение:
//  СправочникСсылка.Организации - Организация по умолчанию
//
Функция ОрганизацияПоУмолчанию() Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ОрганизацияПоУмолчанию();
	
КонецФункции

// Возвращает БИН организации
//
// Параметры:
//  Организация	- СправочникСсылка.Организации - Организация
// 
// Возвращаемое значение:
//  Строка - БИН
//
Функция БИНОрганизации(Организация) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.БИНОрганизации(Организация);
	
КонецФункции

// Возвращает ИИН работника
//
// Параметры:
//  ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица - физическое лицо
// 
// Возвращаемое значение:
//  Строка - ИИН
//
Функция ИИНРаботника(ФизическоеЛицо) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ИИНРаботника(ФизическоеЛицо);
	
КонецФункции

Функция ИдентификаторЭТД(Документ) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ИдентификаторЭТД(Документ);
	
КонецФункции

Функция ПолучитьДанныеСотрудника(Период, Сотрудник) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьДанныеСотрудника(Период, Сотрудник);
	
КонецФункции

Функция ПолучитьПерезаполняемыеДанныеСотрудника() Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьПерезаполняемыеДанныеСотрудника();
	
КонецФункции

Функция ПолучитьТекущегоПользователя() Экспорт

	Возврат ЭТДСерверПереопределяемый.ПолучитьТекущегоПользователя();
	
КонецФункции

Функция ИспользоватьШтатноеРасписание() Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ИспользоватьШтатноеРасписание();
	
КонецФункции

// Возвращает текст запроса для получения основных договоров
// 
// Возвращаемое значение:
//  Строка - Текст запроса
//
Процедура СформироватьЗапросОсновныеДоговоры(Запрос) Экспорт
	
	ЭТДСерверПереопределяемый.СформироватьЗапросОсновныеДоговоры(Запрос);
	
КонецПроцедуры

// Возвращает текст запроса для получения дополнительных соглашений
// 
// Возвращаемое значение:
//  Строка - Текст запроса
//
Процедура СформироватьЗапросДопСоглашения(Запрос) Экспорт
	
	ЭТДСерверПереопределяемый.СформироватьЗапросДопСоглашения(Запрос);
	
КонецПроцедуры

// Возвращает текст запроса для получения договоров ранее уволенных сотрудников
// 
// Возвращаемое значение:
//  Строка - Текст запроса
//
Процедура СформироватьЗапросДоговорыУволенных(Запрос) Экспорт
	
	ЭТДСерверПереопределяемый.СформироватьЗапросДоговорыУволенных(Запрос);
	
КонецПроцедуры

// Возвращает текст запроса для сопоставления должностей
// 
// Возвращаемое значение:
//  Строка - Текст запроса
//
Процедура СформироватьЗапросСопоставлениеДолжностей(Запрос) Экспорт
	
	ЭТДСерверПереопределяемый.СформироватьЗапросСопоставлениеДолжностей(Запрос);
	
КонецПроцедуры

// Функция возвращает дерево значений с данными.
//
Функция ПолучитьДанныеКлассификатора(ВидКлассификатора) Экспорт
	
	Текст = Новый ТекстовыйДокумент;
	Текст = Обработки.ОбменЭТД.ПолучитьМакет("Классификатор"+ВидКлассификатора);
	ТекстМакета = Текст.ПолучитьТекст();
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(ТекстМакета);
		
	Возврат ЗначениеИзСтрокиXML(ТекстМакета);
	
КонецФункции

Функция ЭТД_ЗаписатьЗначениеJSON(Значение) Экспорт
	
	Запись = Новый ЗаписьJSON;
	Запись.УстановитьСтроку();
	ЗаписатьJSON(Запись, Значение);
	
	Возврат Запись.Закрыть();
	
КонецФункции

Функция ЭТД_ПрочитатьЗначениеJSON(Значение, СвойстваДаты = "") Экспорт
	
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(Значение);
	Результат = ПрочитатьJSON(Чтение, Ложь, СвойстваДаты);
	Чтение.Закрыть();
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьСотрудникаПоИИН(ИИН) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьСотрудникаПоИИН(ИИН);
	
КонецФункции

Функция ПолучитьИИНПоСотруднику(Сотрудник) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьИИНПоСотруднику(Сотрудник);
	
КонецФункции

Функция ТекстЗапросаКоличествоДляНумерации() Экспорт 

	Результат =
		"ВЫБРАТЬ
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ЭТД.Ссылка) КАК Количество
		|ИЗ
		|	Документ.ЭТД КАК ЭТД
		|ГДЕ
		|	ЭТД.ОсновнойЭТД = &ОсновнойДоговор";
	
	Возврат Результат;

КонецФункции

Процедура ЗаполнитьПараметрыЭТД(Перезаписать = Ложь, ПараметрыЗаполнения) Экспорт
	
	ПараметрыЭТДКонстанта = Константы.ПараметрыЭТД.Получить();
	Если НЕ ЗначениеЗаполнено(ПараметрыЭТДКонстанта) ИЛИ Перезаписать Тогда
		ПараметрыЭТД = Новый Структура();
		Если ПараметрыЗаполнения.Свойство("АдресСервисаЭТД") Тогда
			ПараметрыЭТД.Вставить("АдресСервисаЭТД", ПараметрыЗаполнения.АдресСервисаЭТД);
		Иначе
			ПараметрыЭТД.Вставить("АдресСервисаЭТД", ЭТДКлиентСервер.АдресПродуктивногоСтенда());
		КонецЕсли;
		ПараметрыЭТД.Вставить("АдресОтправкиДоговоров", "/etd/api/input/sign-contract");
		ПараметрыЭТД.Вставить("АдресОтправкиМассиваДоговоров", "/etd/group/add");
		ПараметрыЭТД.Вставить("АдресПодготовкиНовыхДоговоров", "/etd/api/input/contract");
		ПараметрыЭТД.Вставить("АдресПодготовкиНовыхДопСоглашений", "/etd/api/input/supply");
		ПараметрыЭТД.Вставить("АдресПодготовкиИзменяемыхДоговоров", "/etd/api/edit/contract");
		ПараметрыЭТД.Вставить("АдресПодготовкиИзменяемыхДопСоглашений", "/etd/api/edit/supply");
		ПараметрыЭТД.Вставить("АдресПодготовкиРасторгаемыхДоговоров", "/etd/api/terminate/contract");
		ПараметрыЭТД.Вставить("АдресПодготовкиИмпортаДоговоров", "/etd/sync/get-xml");
		ПараметрыЭТД.Вставить("АдресЗагрузкиДанныхИмпортаДоговоров", "/etd/sync/signed");
		ПараметрыЭТД.Вставить("АдресПроверкиДоступностиСервиса", "/availability");
		ПараметрыЭТД.Вставить("АдресПроверкиДоступностиЕСУТД", "/etd/availability");
		ПараметрыЭТД.Вставить("АдресГрупповогоПолученияДоговоров", "/etd/group/get/contract/");
		ПараметрыЭТД.Вставить("АдресГрупповогоПолученияДопСоглашений", "/etd/group/get/supply/");
		Если ПараметрыЗаполнения.Свойство("ИспользоватьВнешнююКриптографиюДляКомпоненты") Тогда
			ПараметрыЭТД.Вставить("ИспользоватьВнешнююКриптографиюДляКомпоненты", ПараметрыЗаполнения.ИспользоватьВнешнююКриптографиюДляКомпоненты);
		Иначе
			ПараметрыЭТД.Вставить("ИспользоватьВнешнююКриптографиюДляКомпоненты", Ложь);
		КонецЕсли;
		
		ХранилищеПараметров = Новый ХранилищеЗначения(ПараметрыЭТД);
		Константы.ПараметрыЭТД.Установить(ХранилищеПараметров);
	КонецЕсли;
	
КонецПроцедуры

Процедура СоздатьЗаписьЖурналаРегистрации(
	ИмяСобытия, 
	УровеньСтрокой = "", 
	ОбъектМетаданных = Неопределено, 
	Данные = Неопределено, 
	Комментарий = "") Экспорт
	
	ЭТДСерверПереопределяемый.СоздатьЗаписьЖурналаРегистрации(ИмяСобытия, УровеньСтрокой, ОбъектМетаданных, Данные, Комментарий);
	
КонецПроцедуры

Процедура ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(ИсточникиДанных) Экспорт
	
	ЭТДСерверПереопределяемый.ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(ИсточникиДанных);
	
КонецПроцедуры

Процедура ПриЗаполненииВидовОграниченийПравОбъектовМетаданных(Описание) Экспорт
	
	ЭТДСерверПереопределяемый.ПриЗаполненииВидовОграниченийПравОбъектовМетаданных(Описание);
	
КонецПроцедуры

Процедура ПриЗаполненииСписковСОграничениемДоступа(Списки) Экспорт
	
	ЭТДСерверПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа(Списки);
	
КонецПроцедуры

Процедура ПриЗаполненииОграниченияДоступаРегистраСведений(Ограничение, НаименованиеОбъекта) Экспорт
	
	ЭТДСерверПереопределяемый.ПриЗаполненииОграниченияДоступаРегистраСведений(Ограничение, НаименованиеОбъекта);
	
КонецПроцедуры

Процедура ПриЗаполненииОграниченияДоступаЭТД(Ограничение) Экспорт
	
	ЭТДСерверПереопределяемый.ПриЗаполненииОграниченияДоступаЭТД(Ограничение);
	
КонецПроцедуры

Процедура ПриЧтенииНаСервереРегистраСведений(Форма, ТекущийОбъект) Экспорт
	
	ЭТДСерверПереопределяемый.ПриЧтенииНаСервереРегистраСведений(Форма, ТекущийОбъект);
	
КонецПроцедуры

Процедура ПослеЗаписиНаСервереРегистраСведений(Форма, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	ЭТДСерверПереопределяемый.ПослеЗаписиНаСервереРегистраСведений(Форма, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

Процедура ПриЧтенииНаСервереЭТД(Форма, ТекущийОбъект) Экспорт
	
	ЭТДСерверПереопределяемый.ПриЧтенииНаСервереЭТД(Форма, ТекущийОбъект);
	
КонецПроцедуры

Процедура ПослеЗаписиНаСервереЭТД(Форма, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	ЭТДСерверПереопределяемый.ПослеЗаписиНаСервереЭТД(Форма, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

Функция ПолучитьМассивВыбораВладельцыПрофиля() Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьМассивВыбораВладельцыПрофиля();
	
КонецФункции

Процедура ЗаполнитьНаборыЗначенийДоступа(ЭтотОбъект, Таблица) Экспорт
	
	ЭТДСерверПереопределяемый.ЗаполнитьНаборыЗначенийДоступа(ЭтотОбъект, Таблица);
	
КонецПроцедуры

Функция ПолучитьУсловияТрудаПоУмолчанию(ПараметрыПодбора = Неопределено) Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ПолучитьУсловияТрудаПоУмолчанию(ПараметрыПодбора);
	
КонецФункции

#Область Криптобиблиотека

Функция ПолучитьВерсиюВнешнегоМодуляЭТД() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат Константы.ВерсияВнешнегоМодуляЭТД.Получить();
	
КонецФункции

Функция ИспользоватьВнешнююКриптографиюДляКомпоненты() Экспорт
	
	ПараметрыЭТД = ЭТДСерверПовтИсп.ПолучитьПараметрыЭТД();
	Возврат ПараметрыЭТД.ИспользоватьВнешнююКриптографиюДляКомпоненты;
	
КонецФункции

Функция ИнформационнаяБазаФайловая() Экспорт
	
	Возврат ЭТДСерверПереопределяемый.ИнформационнаяБазаФайловая();
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Выполняет преобразование (десериализацию) XML-строки в значение.
// См. также ЗначениеВСтрокуXML.
//
// Параметры:
//  СтрокаXML - Строка - XML-строка, с сериализованным объектом..
//
// Возвращаемое значение:
//  Произвольный - значение, полученное из переданной XML-строки.
//
Функция ЗначениеИзСтрокиXML(СтрокаXML)
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(СтрокаXML);
	
	Возврат СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
КонецФункции

#КонецОбласти
