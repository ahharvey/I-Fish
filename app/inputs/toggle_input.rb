# app/inputs/currency_input.rb
class ToggleInput < SimpleForm::Inputs::BooleanInput


  #  "$ #{@builder.text_field(attribute_name, merged_input_options)}".html_safe


  def boolean_label_class
    options[:boolean_label_class].push('bool-switch') || SimpleForm.boolean_label_class.push('bool-switch')
  end
end
