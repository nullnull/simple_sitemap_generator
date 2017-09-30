require 'spec_helper'

RSpec.describe SimpleSitemapGenerator do
  it 'has a version number' do
    expect(SimpleSitemapGenerator::VERSION).not_to be nil
  end

  it 'works' do
    xml = <<~EOT
<?xml version="1.0" encoding="UTF-8"?>
<urlset hoge:hoge>
  <url>
    <loc>/</loc>
    <changefreq>daily</changefreq>
    <priority>0.5</priority>
  </url>
</urlset>
EOT
    expect(SimpleSitemapGenerator::Sitemap.generate_xml).to eq(xml)
  end
end
