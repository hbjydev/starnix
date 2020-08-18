self: super:
{
  i3-gaps-rounded = super.i3-gaps.overrideAttrs (oldAttrs: rec {
    name = "i3-gaps-rounded";

    src = self.fetchFromGitHub {
      owner = "resloved";
      repo = "i3";
      rev = "f3fffbaef26ac27cda3fe0516dcb27ad404404f0";
      sha256 = "0313wqil0jaszhrf4mn02frg1qqp1vsvdh0dr1kmgfsbcf56y07h";
    };
  });
}
