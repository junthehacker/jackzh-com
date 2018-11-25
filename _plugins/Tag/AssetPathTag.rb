class AssetPathTag < Liquid::Tag
    def initialize(tag_name, input, tokens)
        super
        @input = input
    end

    def render(context)
        output = "#{context['site']['baseUrl']}/assets#{@input.strip}?v=#{context['site']['build']}";
        return output;
    end
end
Liquid::Template.register_tag('asset', AssetPathTag)
