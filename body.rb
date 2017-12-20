V_CONSTANT = 25000
G = 6.67408 * (10 ** -11)
class Body

 attr_accessor :x, :y, :vx, :vy, :mass, :pic, :forces, :g, :ax, :ay, :t, :z_velocity, :z

    def initialize(x, y, vx, vy, mass, pic, radius, z_velocity)
		@vy = vy.to_f
        @mass = mass.to_f       	
       	@pic = pic
        @forces = [0.0, 0.0] 
        @y = y.to_f
        @vx = vx.to_f
        @x = x.to_f
        @radius = radius
        @z_velocity = z_velocity
    	@z = 0
    end

    def how_far(b1,b2)
        dx = (b2.x - b1.x)
        dy = (b2.y - b1.y)
        return [dx, dy]

    end
   def acceleration(f, m)
        return f / m
    end

    def velocity(a, v0)
        return (a * V_CONSTANT) + v0
    end

    def length(b1, b2)
        d = how_far(b1,b2)

        return Math.sqrt(d[0] ** 2 + d[1] ** 2)
    end

    def distance(v0, v)
        return v0 + (v * V_CONSTANT)
    end

    def set_force(f)
    	self.forces[0] = f[0]
    	self.forces[1] = f[1]
    end

    def force_directional(f, d, r)
        return f * (d / r)
    end

    def force(m1, m2, r)
       
        return (G * m1 * m2) / (r ** 2)
    end


    def calc_force(bodies)
        f, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        bodies.each do |body2|
            next if body2 == self
            r = length(self, body2)
            dx = how_far(self, body2)[0]
            dy = how_far(self, body2)[1]

            f = force(mass, body2.mass, r)

            fx += force_directional(f, dx, r)
            fy += force_directional(f, dy, r)

            f = 0.0
        	end
        end

        return [fx, fy]
    end

    def check_for_collisions(bodies)
    	bodies.each do |body2|
    		next if body2 == self
    			if radius + body2.radius > x + body2.x
    				return true
    			else
    				return false
    			end
    		end
    	end
    end

    def set_coords(bodies)
        set_force(calc_force(bodies))

        v0x = vx
        v0y = vy

        ax = acceleration(forces[0], mass)
        ay = acceleration(forces[1], mass)

        self.vx = velocity(ax, v0x)
        self.vy = velocity(ay, v0y)

        self.x += distance(v0x, vx)
        self.y += distance(v0y, vy)
        self.z += velocity(0, z_velocity)
    end

    def set_random_velocities
    	self.vx = rand(1000)
    	self.vy = rand(1000)
    end

    def split(bodies)
    	self.mass = mass/2
    	bodies.push(body)
    end
end