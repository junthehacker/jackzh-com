class RealPathTag < Liquid::Tag
    def initialize(tag_name, input, tokens)
        super
        @input = input
    end

    def render(context)
        output = "#{context['site']['baseUrl']}#{@input.strip}";
        return output;
    end
end

Liquid::Template.register_tag('real_path', RealPathTag)
