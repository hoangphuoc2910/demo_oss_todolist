var builder = WebApplication.CreateBuilder(args);

// 1. Cấu hình CORS mở cho Docker Local
builder.Services.AddCors(options => {
    options.AddPolicy("AllowAll", policy => 
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

builder.Services.AddControllers();

var app = builder.Build();

// 2. Phục vụ index.html từ wwwroot
app.UseDefaultFiles(); 
app.UseStaticFiles();

app.UseCors("AllowAll");
app.MapControllers();

app.Run();