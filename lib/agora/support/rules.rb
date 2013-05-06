module Agora
  module Rules

    module DSL
      def rules
        @rules ||= Hash.new{|h,k| h[k] = []}
      end

      def rule(*ons, &bl)
        ons.each do |on|
          rules[on] << bl
        end
      end
    end

    def self.included(x)
      x.extend(DSL)
    end

    def has_changed(who)
      @to_apply << who
      apply unless @applying
    end

    def apply
      @applying = true
      until @to_apply.empty?
        @current_rule = @to_apply.shift
        self.class.rules[@current_rule].each do |rule|
          rule.call(self, @model)
        end
      end
    ensure
      @applying = false
    end

  end # module Rules
end # module Agora
