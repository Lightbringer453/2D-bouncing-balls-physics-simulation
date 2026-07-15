#include "Image.h"
#include <vector>
#include <cmath>
#include <string>
#include <algorithm>
#include <random>
#include <iostream>
#include <iomanip>
#include <sstream>


struct Vec2 {
    double x, y;
    
    Vec2() : x(0.0), y(0.0) {}
    Vec2(double x, double y) : x(x), y(y) {}
    
    Vec2 operator+(const Vec2& other) const {
        return Vec2(x + other.x, y + other.y);
    }
    
    Vec2 operator-(const Vec2& other) const {
        return Vec2(x - other.x, y - other.y);
    }
    
    Vec2 operator*(double scalar) const {
        return Vec2(x * scalar, y * scalar);
    }
    
    Vec2 operator/(double scalar) const {
        return Vec2(x / scalar, y / scalar);
    }
    
    double dot(const Vec2& other) const {
        return x * other.x + y * other.y;
    }
    
    double length() const {
        return std::sqrt(x * x + y * y);
    }
    
    double lengthSquared() const {
        return x * x + y * y;
    }
    
    Vec2 normalized() const {
        double len = length();
        if (len > 0.0001) {
            return Vec2(x / len, y / len);
        }
        return Vec2(0, 0);
    }
};


struct Ball {
    Vec2 position;
    Vec2 velocity;
    double radius;
    double mass;
    RGBA color;
    
    Ball() : position(0, 0), velocity(0, 0), radius(10.0), mass(1.0) {}
};

//sabitler
const int WIDTH = 800;
const int HEIGHT = 600;
const double GRAVITY = 500.0;  
const double WALL_RESTITUTION = 0.9;
const double BALL_RESTITUTION = 1.0;  
const int NUM_BALLS = 15;
const int TOTAL_FRAMES = 300;
const int SUB_STEPS = 4;
const double DT = 1.0 / 60.0;  //saniyede 60 frame
const double SUB_DT = DT / SUB_STEPS;

//çemberi çizme algolritması
void drawFilledCircle(ColorImage& img, int cx, int cy, int radius, const RGBA& color) {
    int minX = std::max(0, cx - radius);
    int maxX = std::min(img.GetWidth() - 1, cx + radius);
    int minY = std::max(0, cy - radius);
    int maxY = std::min(img.GetHeight() - 1, cy + radius);
    
    int radiusSq = radius * radius;
    
    for (int y = minY; y <= maxY; y++) {
        for (int x = minX; x <= maxX; x++) {
            int dx = x - cx;
            int dy = y - cy;
            int distSq = dx * dx + dy * dy;
            
            if (distSq <= radiusSq) {
                img(x, y) = color;
            }
        }
    }
}

// top collisionları
void resolveBallCollision(Ball& ball1, Ball& ball2) {
    Vec2 delta = ball1.position - ball2.position;
    double dist = delta.length();
    double minDist = ball1.radius + ball2.radius;
    
    if (dist < minDist && dist > 0.0001) {

        Vec2 normal = delta.normalized();
        double overlap = minDist - dist;
        Vec2 separation = normal * (overlap * 0.5);
        
        ball1.position = ball1.position + separation;
        ball2.position = ball2.position - separation;
        
        Vec2 relativeVel = ball1.velocity - ball2.velocity;
        double velAlongNormal = relativeVel.dot(normal);
        
        
        if (velAlongNormal > 0) return;
        
       
        double totalMass = ball1.mass + ball2.mass;
        double impulseScalar = -(1.0 + BALL_RESTITUTION) * velAlongNormal;
        impulseScalar /= totalMass;
        
        Vec2 impulse = normal * impulseScalar;
        ball1.velocity = ball1.velocity + impulse * ball2.mass;
        ball2.velocity = ball2.velocity - impulse * ball1.mass;
    }
}

//duvar collisionları
void handleWallCollision(Ball& ball) {
    //sol duvar
    if (ball.position.x - ball.radius < 0) {
        ball.position.x = ball.radius;
        ball.velocity.x = -ball.velocity.x * WALL_RESTITUTION;
    }
    
    //sağ duvar
    if (ball.position.x + ball.radius > WIDTH) {
        ball.position.x = WIDTH - ball.radius;
        ball.velocity.x = -ball.velocity.x * WALL_RESTITUTION;
    }
    
    //yukarı
    if (ball.position.y - ball.radius < 0) {
        ball.position.y = ball.radius;
        ball.velocity.y = -ball.velocity.y * WALL_RESTITUTION;
    }
    
    //aşağı
    if (ball.position.y + ball.radius > HEIGHT) {
        ball.position.y = HEIGHT - ball.radius;
        ball.velocity.y = -ball.velocity.y * WALL_RESTITUTION;
    }
}


void updatePhysics(std::vector<Ball>& balls) {
    //yerçekimi
    for (auto& ball : balls) {
        ball.velocity.y += GRAVITY * SUB_DT;
    }
    
    //pozisyon update
    for (auto& ball : balls) {
        ball.position = ball.position + ball.velocity * SUB_DT;
    }
    
    for (size_t i = 0; i < balls.size(); i++) {
        for (size_t j = i + 1; j < balls.size(); j++) {
            resolveBallCollision(balls[i], balls[j]);
        }
    }
    
    for (auto& ball : balls) {
        handleWallCollision(ball);
    }
}

//rasgele renk
RGBA randomColor(std::mt19937& rng) {
    std::uniform_int_distribution<int> colorDist(50, 255);
    return RGBA(
        colorDist(rng),
        colorDist(rng),
        colorDist(rng),
        255
    );
}

int main() {
    std::random_device rd;
    std::mt19937 rng(rd());
    std::uniform_real_distribution<double> radiusDist(10.0, 25.0);
    std::uniform_real_distribution<double> posXDist(50.0, WIDTH - 50.0);
    std::uniform_real_distribution<double> posYDist(50.0, HEIGHT - 50.0);
    std::uniform_real_distribution<double> velDist(-200.0, 200.0);
    
    //top oluşturma
    std::vector<Ball> balls(NUM_BALLS);
    for (int i = 0; i < NUM_BALLS; i++) {
        balls[i].radius = radiusDist(rng);
        balls[i].mass = balls[i].radius * balls[i].radius;  
        balls[i].position = Vec2(posXDist(rng), posYDist(rng));
        balls[i].velocity = Vec2(velDist(rng), velDist(rng));
        balls[i].color = randomColor(rng);
        
        //topların başlagiçta çakışmaması
        for (int j = 0; j < i; j++) {
            Vec2 delta = balls[i].position - balls[j].position;
            double dist = delta.length();
            double minDist = balls[i].radius + balls[j].radius;
            
            if (dist < minDist) {
            
                Vec2 normal = delta.normalized();
                if (normal.length() < 0.0001) {
                    normal = Vec2(1, 0); 
                }
                balls[i].position = balls[j].position + normal * minDist;
            }
        }
    }
    
    //fotograf olusturma
    ColorImage img(WIDTH, HEIGHT);
    

    for (int frame = 0; frame < TOTAL_FRAMES; frame++) {
        
        img.Clear();
        
        //physics güncellemesi
        for (int step = 0; step < SUB_STEPS; step++) {
            updatePhysics(balls);
        }
        
        //topları çizme
        for (const auto& ball : balls) {
            int cx = static_cast<int>(ball.position.x);
            int cy = static_cast<int>(ball.position.y);
            int radius = static_cast<int>(ball.radius);
            drawFilledCircle(img, cx, cy, radius, ball.color);
        }
        
        //frame'i kaydetme
        std::ostringstream filename;
        filename << "frame_" << std::setfill('0') << std::setw(3) << frame << ".png";
        img.Save(filename.str());
        
        //progress printleme
        std::cout << "Frame " << (frame + 1) << "/" << TOTAL_FRAMES << " rendered" << std::endl;
    }
    
    std::cout << "Simulation completed and all frames saved." << std::endl;
    
    return 0;
}

