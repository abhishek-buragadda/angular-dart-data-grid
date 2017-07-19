import 'package:angular2/core.dart'
	show Directive, EmbeddedViewRef, Input, TemplateRef, ViewContainerRef;

/// Creates and inserts an embedded view based on a prepared `TemplateRef`.
///
/// ### Syntax
/// - `<template [ngTemplateOutlet]="templateRefExpression"></template>`
@Directive(selector: '[ngTemplateOutletCustom]')
class NgTemplateOutletCustom{
	final ViewContainerRef _viewContainerRef;

	EmbeddedViewRef _insertedViewRef;

	NgTemplateOutletCustom(this._viewContainerRef);

	dynamic _ngTemplateOutletContext;
	dynamic get ngTemplateOutletCustomContext => _ngTemplateOutletContext;
	@Input()
	set ngTemplateOutletCustomContext(dynamic value) {
		_ngTemplateOutletContext = value;
		_updateContext();
	}

	/// Sets the DOM to render the result of [templateRef].
	///
	/// If the template is changed, the previous template is removed first.
	@Input()
	// ignore: avoid_setters_without_getters
	set ngTemplateOutletCustom(TemplateRef templateRef) {
		if (_insertedViewRef != null) {
			_viewContainerRef.remove(_viewContainerRef.indexOf(_insertedViewRef));
		}
		if (templateRef != null) {
			_insertedViewRef = _viewContainerRef.createEmbeddedView(templateRef);
			_updateContext();
		}
	}

	final Set<String> _oldKeys = new Set<String>();

	void _updateContext() {
		if (_insertedViewRef == null) {
			return;
		}
		for (final key in _oldKeys) {
			_insertedViewRef.setLocal(key, null);
		}
		_oldKeys.clear();
		if (ngTemplateOutletCustomContext != null) {
			if (ngTemplateOutletCustomContext is Map &&
				(ngTemplateOutletCustomContext as Map)
					.keys
					.every((dynamic key) => key is String)) {
				final context = ngTemplateOutletCustomContext as Map<String, dynamic>;
				for (final key in context.keys) {
					_insertedViewRef.setLocal(key, ngTemplateOutletCustomContext[key]);
				}
				_oldKeys.addAll(context.keys);
			} else {
				_insertedViewRef.setLocal(r'$implicit', ngTemplateOutletCustomContext);
				_oldKeys.add(r'$implicit');
			}
			_insertedViewRef.markForCheck();
		}
	}
}