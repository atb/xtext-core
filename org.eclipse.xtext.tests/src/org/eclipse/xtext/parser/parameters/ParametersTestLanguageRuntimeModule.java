/*
 * generated by Xtext
 */
package org.eclipse.xtext.parser.parameters;

import org.eclipse.xtext.common.services.DefaultTerminalConverters;
import org.eclipse.xtext.conversion.IValueConverterService;
import org.eclipse.xtext.conversion.ValueConverter;
import org.eclipse.xtext.conversion.impl.KeywordAlternativeConverter;

import com.google.inject.Inject;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class ParametersTestLanguageRuntimeModule extends org.eclipse.xtext.parser.parameters.AbstractParametersTestLanguageRuntimeModule {
	@Override
	public Class<? extends IValueConverterService> bindIValueConverterService() {
		return Converters.class;
	}
	
	public static class Converters extends DefaultTerminalConverters {
		@Inject KeywordAlternativeConverter converter;
		
		@ValueConverter(rule="IdOrKeyword")
		public KeywordAlternativeConverter IdOrKeyword() {
			return converter;
		}
		
	}
}
