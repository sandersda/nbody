require "gosu"
require_relative "z_order"
DISTANCE_CONSTANT = 320

class Simulation

    attr_reader :number_of_bodies, :radius, :bodies

    def initialize(number_of_bodies, radius, bodies)
        @number_of_bodies = number_of_bodies.to_i
        @radius = radius.to_f
        @bodies = bodies

        bodies[0].calc_force(bodies)
    end

    def convert_coords(x, y, img)
        return [((DISTANCE_CONSTANT * x) / radius) + DISTANCE_CONSTANT - (img.width / 2), ((DISTANCE_CONSTANT * y) / radius) + DISTANCE_CONSTANT - (img.height / 2)]
    end

    def update
        bodies.each do |body|
            body.set_coords(bodies)
            if body.check_for_collisions(bodies)
            	body.split(bodies)
            	body.set_random_velocities
            end
        end
    end

    def draw
        bodies.each do |body|
            body_image = Gosu::Image.new("images/#{body.pic}")
            coords = convert_coords(body.x, -body.y, body_image)
            body_image.draw(coords[0], coords[1], body.z, scale_x = 1/body.z, scale_y = 1/body.y)
        end
    end


end