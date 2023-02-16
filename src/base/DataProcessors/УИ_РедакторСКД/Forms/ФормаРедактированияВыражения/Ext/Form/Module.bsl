﻿#Область ОписаниеПеременных

&НаКлиенте
Перем УИ_РедакторКодаКлиентскиеДанные Экспорт;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Заголовок") Тогда
		Заголовок  = Параметры.Заголовок;
	КонецЕсли;

	ТекстВыражения = Параметры.Текст;
	
	ЗаполнитьДоступныеПоляСКД();
	
	УИ_РедакторКодаСервер.ФормаПриСозданииНаСервере(ЭтотОбъект);

	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект,
													   "Выражение",
													   Элементы.ПолеРедактированияВыражения,
													   ,
													   "dcs_query");
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УИ_РедакторКодаКлиент.ФормаПриОткрытии(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы


&НаКлиенте
Процедура ПоляСКДВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	ДанныеСтроки = ПоляСКД.НайтиПоИдентификатору(ВыбраннаяСтрока);
	УИ_РедакторКодаКлиент.ВставитьТекстПоПозицииКурсора(ЭтотОбъект, "Выражение", ДанныеСтроки.ПутьКДанным);
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Применить(Команда)
	Закрыть(ТекущийТекстВыражения());
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область РедакторКода

&НаКлиенте
Процедура УстановитьТекстВыражения(НовыйТекст, УстанавливатьОригинальныйТекст = Ложь, НовыйОригинальныйТекст = "")
	УИ_РедакторКодаКлиент.УстановитьТекстРедактора(ЭтотОбъект, "Выражение", НовыйТекст);

	Если УстанавливатьОригинальныйТекст Тогда
		УИ_РедакторКодаКлиент.УстановитьОригинальныйТекстРедактора(ЭтотОбъект, "Выражение", НовыйОригинальныйТекст);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция ТекущийТекстВыражения()
	Возврат УИ_РедакторКодаКлиент.ТекстКодаРедактора(ЭтотОбъект, "Выражение");
КонецФункции

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораДокументСформирован(Элемент)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLДокументСформирован(ЭтотОбъект, Элемент);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLПриНажатии(ЭтотОбъект, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяИнициализацияРедакторов()
	УИ_РедакторКодаКлиент.РедакторКодаОтложеннаяИнициализацияРедакторов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РедакторКодаЗавершениеИнициализации() Экспорт
	УстановитьТекстВыражения(ТекстВыражения, Истина, ТекстВыражения);
	УИ_ДобавитьКонтекстПолей();
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяОбработкаСобытийРедактора() Экспорт
	УИ_РедакторКодаКлиент.ОтложеннаяОбработкаСобытийРедактора(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ЗаполнитьДоступныеПоляСКД()
	
	ВидыПолей = Параметры.ВидыПолейНаборовДанных;
	КартинкаРеквизит=БиблиотекаКартинок.Реквизит;
	КартинкаПроизвольноеВыражение=БиблиотекаКартинок.ПроизвольноеВыражение;
	КартинкаПапка = БиблиотекаКартинок.Папка;
	
	СоответствиеИдентификаторовСтрок = Новый Соответствие;

	Для Каждого ТекПоле ИЗ Параметры.Поля Цикл
		Если ТекПоле.Вид <> ВидыПолей.Поле Тогда
			Продолжить;
		КонецЕсли;
		
		МассивПути = СтрРазделить(ТекПоле.ПутьКДанным, ".", Ложь);
		
		ТекПуть = "";
		ТекущийРодитель = ПоляСКД;
		
		Для ИндексПути=0  По МассивПути.Количество()-1 Цикл
			ЭлементПути = МассивПути[ИндексПути];
			
			ТекПуть = ТекПуть + ?(ЗначениеЗаполнено(ТекПуть),".","") + ЭлементПути;
			
			Если ТекПуть = ТекПоле.ПутьКДанным Тогда
				НовоеПоле = ТекущийРодитель.ПолучитьЭлементы().Добавить();
				НовоеПоле.Поле = ЭлементПути;
				НовоеПоле.ПутьКДанным = ТекПуть;
				НовоеПоле.ТипЗначения = ТекПоле.ТипЗначения;
				Если НовоеПоле.ТипЗначения = Новый ОписаниеТипов Тогда
					НовоеПоле.ТипЗначения = ТекПоле.ТипЗначенияЗапроса;
				КонецЕсли;
				Если ТекПоле.ВычисляемоеПоле Тогда
					НовоеПоле.Картинка = КартинкаПроизвольноеВыражение;	
				Иначе
					НовоеПоле.Картинка = КартинкаРеквизит;
				КонецЕсли;
				
				Продолжить;
			КонецЕсли;
			
			ИдентификаторСтроки = СоответствиеИдентификаторовСтрок[НРег(ТекПуть)];
			Если ИдентификаторСтроки = Неопределено Тогда
				НовоеПоле = ТекущийРодитель.ПолучитьЭлементы().Добавить();
				НовоеПоле.Поле = ЭлементПути;
				НовоеПоле.ПутьКДанным = ТекПуть;
				НовоеПоле.ТипЗначения = Новый ОписаниеТипов("Число");
				НовоеПоле.Картинка = КартинкаПапка;

				ИдентификаторСтроки = НовоеПоле.ПолучитьИдентификатор();
				СоответствиеИдентификаторовСтрок.Вставить(НРег(ТекПуть), ИдентификаторСтроки);
				
				ТекущийРодитель = НовоеПоле;
			Иначе
				ТекущийРодитель = ПоляСКД.НайтиПоИдентификатору(ИдентификаторСтроки);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	ПапкаСистемныеПоля = ПоляСКД.ПолучитьЭлементы().Добавить();
	ПапкаСистемныеПоля.ПутьКДанным = "СистемныеПоля";
	ПапкаСистемныеПоля.Поле = "СистемныеПоля";
	ПапкаСистемныеПоля.Картинка = КартинкаПапка;
	
	НовоеПоле = ПапкаСистемныеПоля.ПолучитьЭлементы().Добавить();
	НовоеПоле.Поле = "НомерПоПорядку";
	НовоеПоле.ПутьКДанным = ПапкаСистемныеПоля.ПутьКДанным+"."+НовоеПоле.Поле;
	НовоеПоле.ТипЗначения = Новый ОписаниеТипов("Число");
	НовоеПоле.Картинка = КартинкаРеквизит;
	
	НовоеПоле = ПапкаСистемныеПоля.ПолучитьЭлементы().Добавить();
	НовоеПоле.Поле = "НомерПоПорядкуВГруппировке";
	НовоеПоле.ПутьКДанным = ПапкаСистемныеПоля.ПутьКДанным+"."+НовоеПоле.Поле;
	НовоеПоле.ТипЗначения = Новый ОписаниеТипов("Число");
	НовоеПоле.Картинка = КартинкаРеквизит;
	
	НовоеПоле = ПапкаСистемныеПоля.ПолучитьЭлементы().Добавить();
	НовоеПоле.Поле = "Уровень";
	НовоеПоле.ПутьКДанным = ПапкаСистемныеПоля.ПутьКДанным+"."+НовоеПоле.Поле;
	НовоеПоле.ТипЗначения = Новый ОписаниеТипов("Число");
	НовоеПоле.Картинка = КартинкаРеквизит;
	
	НовоеПоле = ПапкаСистемныеПоля.ПолучитьЭлементы().Добавить();
	НовоеПоле.Поле = "УровеньВГруппировке";
	НовоеПоле.ПутьКДанным = ПапкаСистемныеПоля.ПутьКДанным+"."+НовоеПоле.Поле;
	НовоеПоле.ТипЗначения = Новый ОписаниеТипов("Число");
	НовоеПоле.Картинка = КартинкаРеквизит;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьКонтекстГруппыПолей(СтруктураДополнительногоКонтекста, СтрокаПолейСКД, ПустоеОписаниеТипов)
	Для Каждого ДоступнаяПеременная Из СтрокаПолейСКД.ПолучитьЭлементы() Цикл
		КоллекцияПодчиненных = ДоступнаяПеременная.ПолучитьЭлементы();
		Если КоллекцияПодчиненных.Количество() = 0 Тогда
			Типы = ДоступнаяПеременная.ТипЗначения.Типы();
			Если Типы.Количество() = 0 Тогда
				СтруктураПеременной = "";
			Иначе
				СтруктураПеременной = Типы[0];
			КонецЕсли;
		Иначе
			СтруктураПеременной = Новый Структура;
			Если ДоступнаяПеременная.ТипЗначения = ПустоеОписаниеТипов Тогда
				СтруктураПеременной.Вставить("Тип", "");
			Иначе
				СтруктураПеременной.Вставить("Тип", ДоступнаяПеременная.ТипЗначения);
			КонецЕсли;
			ПодчиненныеСвойства = Новый Структура;
			
			ДобавитьКонтекстГруппыПолей(ПодчиненныеСвойства, ДоступнаяПеременная, ПустоеОписаниеТипов);
			СтруктураПеременной.Вставить("ПодчиненныеСвойства", ПодчиненныеСвойства);
			
		КонецЕсли;
		
		СтруктураДополнительногоКонтекста.Вставить(ДоступнаяПеременная.Поле, СтруктураПеременной);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура УИ_ДобавитьКонтекстПолей()
	СтруктураДополнительногоКонтекста = Новый Структура;

	ПустоеОписаниеТипов = Новый ОписаниеТипов;
	
	ДобавитьКонтекстГруппыПолей(СтруктураДополнительногоКонтекста, ПоляСКД, ПустоеОписаниеТипов);
	
	УИ_РедакторКодаКлиент.ДобавитьКонтекстРедактораКода(ЭтотОбъект, "Выражение", СтруктураДополнительногоКонтекста);

КонецПроцедуры


#КонецОбласти