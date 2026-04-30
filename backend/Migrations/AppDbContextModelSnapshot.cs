using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using StudentApi.Data;

#nullable disable

namespace StudentApi.Migrations;

[DbContext(typeof(AppDbContext))]
partial class AppDbContextModelSnapshot : ModelSnapshot
{
    protected override void BuildModel(ModelBuilder modelBuilder)
    {
#pragma warning disable 612, 618
        modelBuilder
            .HasAnnotation("ProductVersion", "8.0.0")
            .HasAnnotation("Relational:MaxIdentifierLength", 128);

        SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

        modelBuilder.Entity("StudentApi.Models.Student", b =>
        {
            b.Property<int>("Id")
             .ValueGeneratedOnAdd()
             .HasColumnType("int");

            SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

            b.Property<string>("Name")
             .IsRequired()
             .HasMaxLength(100)
             .HasColumnType("nvarchar(100)");

            b.Property<string>("RollNo")
             .IsRequired()
             .HasMaxLength(20)
             .HasColumnType("nvarchar(20)");

            b.Property<string>("Class")
             .IsRequired()
             .HasMaxLength(50)
             .HasColumnType("nvarchar(50)");

            b.Property<string>("City")
             .IsRequired()
             .HasMaxLength(100)
             .HasColumnType("nvarchar(100)");

            b.Property<DateTime>("CreatedAt")
             .HasColumnType("datetime2");

            b.HasKey("Id");
            b.HasIndex("RollNo").IsUnique();
            b.ToTable("Students");
        });
#pragma warning restore 612, 618
    }
}
