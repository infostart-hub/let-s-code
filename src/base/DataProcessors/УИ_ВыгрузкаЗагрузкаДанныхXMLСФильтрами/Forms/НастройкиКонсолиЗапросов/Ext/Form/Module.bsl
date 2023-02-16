﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ВариантИспользованияКонсолиЗапросов = Параметры.ВариантИспользованияКонсолиЗапросов;
	ПутьКВнешнейКонсолиЗапросов = Параметры.ПутьКВнешнейКонсолиЗапросов;

	Элементы.ПутьКВнешнейКонсолиЗапросов.Доступность = (ВариантИспользованияКонсолиЗапросов = 2);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВариантИспользованияКонсолиЗапросовПриИзменении(Элемент)

	Элементы.ПутьКВнешнейКонсолиЗапросов.Доступность = (ВариантИспользованияКонсолиЗапросов = 2);

КонецПроцедуры

&НаКлиенте
Процедура ПутьКВнешнейКонсолиЗапросовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.ПроверятьСуществованиеФайла = Истина;
	Диалог.Фильтр = НСтр("ru='Внешние обработки (*.epf)|*.epf'");
	Диалог.Показать(Новый ОписаниеОповещения("ПутьКВнешнейКонсолиЗапросовНачалоВыбораЗавершение", ЭтаФорма,
		Новый Структура("Диалог", Диалог)));

КонецПроцедуры

&НаКлиенте
Процедура ПутьКВнешнейКонсолиЗапросовНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт

	Диалог = ДополнительныеПараметры.Диалог;
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		ПутьКВнешнейКонсолиЗапросов = Диалог.ПолноеИмяФайла;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Подтвердить(Команда)

	НастройкиКонсолиЗапросов = Новый Структура;
	НастройкиКонсолиЗапросов.Вставить("ВариантИспользованияКонсолиЗапросов", ВариантИспользованияКонсолиЗапросов);
	НастройкиКонсолиЗапросов.Вставить("ПутьКВнешнейКонсолиЗапросов", ПутьКВнешнейКонсолиЗапросов);

	Оповестить("ЗакрытаФормаНастройкиКонсолиЗапросов", НастройкиКонсолиЗапросов);

	Закрыть();

КонецПроцедуры

#КонецОбласти