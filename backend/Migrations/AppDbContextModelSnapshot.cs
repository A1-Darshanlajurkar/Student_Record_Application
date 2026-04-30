using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using StudentApi.Data;

#nullable disable

namespace StudentApi.Migrations;

[DbContext(typeof(AppDbContext))]
partial class AppDbContextModelSnapshot : ModelSnapshot
{
    protected override void BuildModel(ModelBuilder modelBuilder)
    {
#pragma warning disable 612, 618
        modelBuilder.HasAnnotation("ProductVersion", "8.0.0")
                    .HasAnnotation("Relational:MaxIdentifierLength", 128);

        modelBuilder.HasAnnotation("SqlServer:ValueGenerationStrategy",
            Microsoft.EntityFrameworkCore.SqlServer.ValueGenerationStrategy.IdentityColumn);

        modelBuilder.Entity("StudentApi.Models.Student", b =>
        {
            b.Property<int>("Id").ValueGeneratedOnAdd()
             .HasColumnType("int")
             .HasAnnotation("SqlServer:ValueGenerationStrategy",
                 Microsoft.EntityFrameworkCore.SqlServer.ValueGenerationStrategy.IdentityColumn);
            b.Property<string>("Name")    .HasMaxLength(100).HasColumnType("nvarchar(100)").IsRequired();
            b.Property<string>("RollNo")  .HasMaxLength(20) .HasColumnType("nvarchar(20)") .IsRequired();
            b.Property<string>("Class")   .HasMaxLength(50) .HasColumnType("nvarchar(50)") .IsRequired();
            b.Property<string>("City")    .HasMaxLength(100).HasColumnType("nvarchar(100)").IsRequired();
            b.Property<DateTime>("CreatedAt").HasColumnType("datetime2");
            b.HasKey("Id");
            b.HasIndex("RollNo").IsUnique();
            b.ToTable("Students");
        });
#pragma warning restore 612, 618
    }
}
