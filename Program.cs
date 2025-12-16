var builder = WebApplication.CreateBuilder(args);

// --- BẮT ĐẦU SỬA ---
// 1. Đăng ký dịch vụ CORS (Phải bọc trong AddCors)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", // Đặt tên ngắn gọn là AllowAll
        policy => policy.AllowAnyOrigin()  // Chấp nhận mọi nơi (InfinityFree, Localhost...)
                        .AllowAnyMethod()
                        .AllowAnyHeader());
});
// --- KẾT THÚC SỬA ---

builder.Services.AddControllers();

var app = builder.Build();

// 2. Kích hoạt CORS (Dùng đúng tên đã đặt ở trên)
app.UseCors("AllowAll");

app.UseAuthorization();
app.MapControllers();

app.Run();