FactoryBot.define do
  factory :user do
    name              "Johndo"
    email             "herecomes@john.ny"
    password_digest   "password"
    fsa_id              1
    phone             '1112223334'
    # gender            "Male"
    # orientation       "straight"
    # looking_for       "friendship"
  end
end
