// Entry point for the build script in your package.json
import Rails from "@rails/ujs"
Rails.start()

import "@hotwired/turbo-rails"
import "./controllers"

import "./brand_autocomplete";
import "./hamburger_menu";
import "./radar_chart";
import "./range_slider";
import "./like_animation";
import "./like_ajax";

