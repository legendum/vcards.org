module VCards
  def self.brands
    Thread.current[:brands] ||= DataStruct.new(
      default: :vcards,
      hosts: {
        'vcards.local' => :vcards,
        'vcards.org' => :vcards,
        'www.vcards.org' => :vcards,
      },
      vcards: {
        email: {
          admin: '"Kevin Hutchinson" <legendum@gmail.com>',
          sender: '"vCards.org" <vcards@legendum.com>',
        },
      }
    )
  end
end
