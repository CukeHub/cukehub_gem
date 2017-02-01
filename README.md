###Get Started
1. SignUp @ CukeHub http://cukehub.com/users/sign_up
2. Create a New Test **App** Container (http://cukehub.com/apps/new) and retrieve your unique App **Token** for your Cucumber Reposiotry from the Edit App page.
3. Add **`gem 'cukehub'`** to your Test Repository GemFile (**`gem 'cukehub', :require => false`** in Rails GemFile)
4. Add **`require ‘cukehub’`** to your features/support/env.rb file
5. Add **`@cukehub_token = “< token >”`** to your features/support/env.rb Before Hook.
6. Run your cukes **`$ cucumber features`**
7. Visit http://cukehub.com/apps and Analyze Cuke Results.
8. Inivte your team and friends to CukeHub!




