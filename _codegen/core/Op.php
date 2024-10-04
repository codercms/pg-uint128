<?php

declare(strict_types=1);

require_once __DIR__ . '/OpConfig.php';

enum Op: string
{
    case Eq = 'eq';
    case Ne = 'ne';
    case Gt = 'gt';
    case Lt = 'lt';
    case Ge = 'ge';
    case Le = 'le';

    case Add = 'add';
    case Sub = 'sub';
    case Mul = 'mul';
    case Div = 'div';
    case Mod = 'mod';

    case Xor = 'xor';
    case And = 'and';
    case Or = 'or';
    case Not = 'not';

    case Shl = 'shl';
    case Shr = 'shr';

    public function isCMP(): bool
    {
        return match ($this) {
            self::Eq, self::Ne, self::Gt, self::Lt, self::Ge, self::Le => true,
            default => false,
        };
    }

    public function isArithmetic(): bool
    {
        return match ($this) {
            self::Add, self::Sub, self::Mul, self::Div, self::Mod => true,
            default => false,
        };
    }

    public function canOverflow(): bool
    {
        return match ($this) {
            self::Add, self::Sub, self::Mul => true,
            default => false,
        };
    }

    public function isDivision(): bool
    {
        return match ($this) {
            self::Div, self::Mod => true,
            default => false,
        };
    }

    public function config(): OpConfig
    {
        return match ($this) {
            self::Eq => new OpConfig(
                cOp: '==',
                sign: '=',
                commutator: '=',
                negator: '<>',
                restrict: 'eqsel',
                join: 'eqjoinsel',
                hashes: true,
                merges: true,
            ),
            self::Ne => new OpConfig(
                cOp: '!=',
                sign: '<>',
                commutator: '<>',
                negator: '=',
                restrict: 'neqsel',
                join: 'neqjoinsel',
                hashes: true,
                merges: true,
            ),
            self::Gt => new OpConfig(
                cOp: '>',
                sign: '>',
                commutator: '>',
                negator: '<=',
                restrict: 'scalargtsel',
                join: 'scalargtjoinsel',
            ),
            self::Lt => new OpConfig(
                cOp: '<',
                sign: '<',
                commutator: '<',
                negator: '>=',
                restrict: 'scalarltsel',
                join: 'scalarltjoinsel',
            ),
            self::Ge => new OpConfig(
                cOp: '>=',
                sign: '>=',
                commutator: '>=',
                negator: '<',
                restrict: 'scalargtsel',
                join: 'scalargtjoinsel',
            ),
            self::Le => new OpConfig(
                cOp: '<=',
                sign: '<=',
                commutator: '<=',
                negator: '>',
                restrict: 'scalarltsel',
                join: 'scalarltjoinsel',
            ),

            self::Add => new OpConfig(
                cOp: '+',
                sign: '+',
                commutator: '+'
            ),
            self::Sub => new OpConfig(
                cOp: '-',
                sign: '-',
                commutator: '-'
            ),
            self::Mul => new OpConfig(
                cOp: '*',
                sign: '*',
            ),
            self::Div => new OpConfig(
                cOp: '/',
                sign: '/'
            ),
            self::Mod => new OpConfig(
                cOp: '%',
                sign: '%'
            ),

            self::Xor => new OpConfig(
                cOp: '^',
                sign: '#',
                commutator: '#'
            ),
            self::And => new OpConfig(
                cOp: '&',
                sign: '&',
                commutator: '&'
            ),
            self::Or => new OpConfig(
                cOp: '|',
                sign: '|',
                commutator: '|'
            ),
            self::Not => new OpConfig(
                cOp: '~',
                sign: '~',
            ),

            self::Shl => new OpConfig(
                cOp: '<<',
                sign: '<<'
            ),
            self::Shr => new OpConfig(
                cOp: '>>',
                sign: '>>'
            ),
        };
    }
}
