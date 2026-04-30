using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudentApi.Migrations;

public partial class InitialCreate : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.CreateTable(
            name: "Students",
            columns: table => new
            {
                Id = table.Column<int>(type: "int", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Name      = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                RollNo    = table.Column<string>(type: "nvarchar(20)",  maxLength: 20,  nullable: false),
                Class     = table.Column<string>(type: "nvarchar(50)",  maxLength: 50,  nullable: false),
                City      = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_Students", x => x.Id);
            });

        migrationBuilder.CreateIndex(
            name:   "IX_Students_RollNo",
            table:  "Students",
            column: "RollNo",
            unique: true);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropTable(name: "Students");
    }
}
